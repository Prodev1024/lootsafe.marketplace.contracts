pragma solidity ^0.4.24;

import "../Market.sol";

contract MarketEvents {
    Market public market;

    constructor () {
        market = Market(msg.sender);
    }

    modifier only_auction_house {
        require (msg.sender == address(market), "UNAUTHORIZED SENDER");
        _;
    }

    /// @notice Let the world know a new merchant vault has been created
    /// @param merchant The merchant who has created a Vault
    /// @param vault The address of the Vault that has been created
    event VaultCreated (address merchant, address vault);
    function vault_created (address merchant, address vault)
        public 
        only_auction_house 
    {
        emit VaultCreated(merchant, vault);
    }

    /// @notice Listing created event
    /// @param merchant The merchant who has created the listing
    /// @param id The id of the listing that has been created
    event ListingCreated (address merchant, uint id);
    function listing_created (address merchant, uint id) 
        public 
        only_auction_house 
    {
        emit ListingCreated(merchant, id);
    }

    /// @notice Listing fulfilled event
    /// @param id The ID of the lisiing being fulfilled
    /// @param buyer The address of the buyer
    event ListingFulfilled (uint id, address buyer);
    function listing_fulfilled (uint id, address buyer)
        public
        only_auction_house
    {
        emit ListingFulfilled(id, buyer);
    }

    /// @notice Listing canceled event
    /// @param id The id of the listing that has been cancelled
    event ListingCancelled (uint id);
    function listing_cancelled (uint id)
        public
        only_auction_house
    {
        emit ListingCancelled(id);
    }
}