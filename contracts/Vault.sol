// Restricted access wallet contract
// https://github.com/lootsafe/lootsafe.auctionhou.se.contracts
pragma solidity ^0.4.24;

import "./lib/EIP20Interface.sol";
import "./Market.sol";

contract Vault {
    /* The Vault acts as a storage account managed by two parties.
    Either the Contract (Market) or the Merchant (you!) can
    withdraw or manage funds accordingly, additional security is 
    added to prevent wasting other parties gas, for instance if an
    asset is locked in a listing offer the vault will prevent withdraw 
    preventing failed transactions and wasted gas from parties trying 
    to fulfil the listing later on.
    */

    /// @notice Assets currently locked in functionality by parent contract
    mapping (address => uint256) locked_assets;

    Market public parent; // Origin contract
    address public merchant; // Owner of this inventory

    /// @notice Allows ONLY the merchant to execute
    modifier only_merchant {
        require(msg.sender == merchant, "UNAUTHORIZED MERCHANT SENDER");
        _;
    }

    /// @notice Allow ONLY the parent contract to execute
    modifier only_parent {
        require(msg.sender == address(parent), "UNAUTHORIZED PARENT SENDER");
        _;
    }

    /// @notice Allows both parties to execute
    modifier multi_auth {
        require(msg.sender == address(parent) || msg.sender == merchant, "UNAUTHORIZED MULTIAUTH SENDER");
        _;
    }

    /// @notice Vault constructor
    /// @param _merchant The owner of this Vault, 
    constructor (address _merchant) public {
        parent = Market(msg.sender);
        merchant = _merchant;
    }

    /// @notice Check balances of assets
    /// @param asset Address of asset to check balance of
    /// @param value Value expected to have
    function has_balance (address asset, uint256 value) public returns (bool) {
        return (EIP20Interface(asset).balanceOf(this) >= value);
    }

    /// @notice Lock assets from withdraw
    /// @param asset Address of asset to be locked up
    /// @param amount Amount of asset to lock up
    function lock_asset (address asset, uint256 amount) public only_parent {
        locked_assets[asset] += amount;
    }

    /// @notice Unlock assets from withdraw
    /// @param asset Address of asset to be unlocked
    /// @param amount Amount of asset to unlocked
    function unlock_asset (address asset, uint256 amount) public only_parent {
        require(locked_assets[asset] >= amount, "UNDERFLOW OF LOCKED ASSETS");
        locked_assets[asset] = locked_assets[asset] - amount;
    }
    

    /// @notice Allow withdraw of non-locked funds
    /// @param asset The asset the merchant want's to withdraw
    /// @param value The amount of asset to be transferred
    function withdrawal (address asset, uint256 value) public only_merchant {
        EIP20Interface i_asset = EIP20Interface(asset);
        uint256 balance = i_asset.balanceOf(this);
        uint256 locked = locked_assets[asset];
        require(balance - locked >= value, "INSUFFICIENT OR LOCKED VAULT BALANCE");
        i_asset.transfer(merchant, value);
    }

    /// @notice Allow the creator to run transfers of assets
    /// @param to The address to transfer to
    /// @param asset The asset to transfer
    /// @param value The amount of asset to be transferred
    function transfer (address to, address asset, uint256 value) public only_parent {
        EIP20Interface i_asset = EIP20Interface(asset);
        i_asset.transfer(to, value);
    }

    /// @notice redeem accidental ETH sent to the contract
    function ether_saver () public only_merchant {
        msg.sender.transfer(address(this).balance);
    }
}
