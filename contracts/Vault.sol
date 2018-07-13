// https://github.com/lootsafe/lootsafe.auctionhou.se.contracts
pragma solidity ^0.4.12;

import "./lib/EIP20Interface.sol";
import "./AuctionHouse.sol";

contract Vault {
    /* The Vault acts as a storage account managed by two parties.
    Either the Market (AuctionHouse) or the merchant (you!) can 
    withdraw or manage funds accordingly, additional security is 
    added to prevent wasting other parties gas, for instance if an
    asset is locked in a listing offer the vault will prevent withdraw 
    preventing failed transactions and wasted gas from parties trying 
    to fulfil the listing later on.
    */

    AuctionHouse public auctionHouse; // Origin marketplace
    address public merchant; // Owner of this inventory

    /// @notice Allows ONLY the merchant to execute
    modifier onlyMerchant {
        require(msg.sender == merchant);
        _;
    }

    /// @notice Allow ONLY the auction house
    modifier onlyAuctionHouse {
        require(msg.sender == address(auctionHouse));
        _;
    }

    /// @notice Allows both parties to execute
    modifier multiAuth {
        require(msg.sender == address(auctionHouse) || msg.sender == merchant);
        _;
    }

    /// @notice Vault constructor
    /// @param _merchant The owner of this Vault, 
    constructor (address _merchant) public {
        auctionHouse = AuctionHouse(msg.sender);
        merchant = _merchant;
    }

    /// @notice allow the merchant to withdraw funds that are NOT locked in listings
    /// @param _asset The asset the merchant want's to withdraw
    /// @param _value The amount of asset to be transferred
    function withdrawal (address _asset, uint256 value) public onlyAuctionHouse {
        EIP20Interface asset = EIP20Interface(_asset);
        asset.transfer(merchant, value);
    }

    /// @notice allow the auction house to transfer assets when purchased
    /// @param _to The address to transfer to
    /// @param _asset The asset to transfer
    /// @param _value The amount of asset to be transferred
    function transfer (address _to, address _asset, uint256 _value) public onlyAuctionHouse {
        EIP20Interface asset = EIP20Interface(_asset);
        asset.transfer(_to, _value);
    }

    /// @notice redeem accidental ETH sent to the contract
    function etherSaver () public onlyMerchant {
        msg.sender.transfer(address(this).balance);
    }
}
