pragma solidity ^0.4.12;

import "../AuctionHouse.sol";

contract AuctionEvents {
    AuctionHouse public auctionHouse;

    modifier onlyAuctionHouse {
        require (msg.sender == address(auctionHouse));
        _;
    }

    /// @notice Let the world know a new merchant vault has been created
    /// @param merchant The merchant who has created a Vault
    /// @param vault The address of the Vault that has been created
    event VaultCreated (address merchant, address vault);
    function vaultCreated (address merchant, address vault) 
        public 
        onlyAuctionHouse 
    {
        emit VaultCreated(merchant, vault);
    }
}