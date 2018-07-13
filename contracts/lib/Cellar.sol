// The celler contains all libraries needed for the auction house

pragma solidity ^0.4.12;

library Cellar {
    // Represents a market listing
    struct Listing {
        address offer;
        address request;
        uint256 offerValue;
        uint256 requestValue;
        address merchant;
        address customer;
        uint settleTime;
        bool settled;
    }
}