// The celler contains all libraries needed for the auction house
pragma solidity ^0.4.24;

library Cellar {
    // Represents a market listing
    struct Listing {
        uint256 id;         // ID of the listing
        uint256 date;       // When was the listing listed
        address merchant;   // Address of Merchant
        address asset;      // What item are they selling
        uint256 amount;     // How many of the item are they selling
        uint256 value;      // How much are they selling the item for
    }
}