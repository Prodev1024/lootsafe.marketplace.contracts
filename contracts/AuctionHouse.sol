pragma solidity ^0.4.24;

import "./lib/Cellar.sol";
import "./lib/AuctionEvents.sol";
import "./Vault.sol";

contract AuctionHouse {
    using Cellar for Cellar.Listing;
    AuctionEvents public auction_events;

    struct Listing {
        uint256 id;         // ID of the listing
        uint256 date;       // When was the listing listed
        address merchant;   // Address of Merchant
        address asset;      // What item are they selling
        uint256 amount;     // How many of the item are they selling
        uint256 value;      // How much are they selling the item for
    }

    address public base;
    address public owner;

    Listing[] public listings;
    uint[] public listing_ids;

    mapping (address => address) public vaults;

    constructor (address _base) public {
        owner = msg.sender;
        base = _base;
    }

    /// @notice Get all listing ids
    /// @return Returns uint list of all active listing ids
    function get_listings () public view returns (uint[]) {
        return listing_ids;
    }

    /// @notice Get a listing by id
    /// @return returns listing... id, date, merchant, asset, amount, value
    function get_listing (uint id) public view returns (uint256, uint256, address, address, uint256, uint256) {
        Listing memory listing = listings[id];
        return (
            listing.id,
            listing.date,
            listing.merchant,
            listing.asset,
            listing.amount,
            listing.value
        );
    }

    /// @notice Create a listing on the marketplace
    /// @param asset Address of asset to sell
    /// @param amount Amount of asset to sell
    /// @param value How much to sell asset for
    function create_listing (address asset, uint256 amount, uint256 value) public {
        address vault = vaults[msg.sender];
        require(vault != 0x0, "NO VAULT EXISTS");
        require(Vault(vault).has_balance(asset, amount), "INSUFFICIENT VAULT BALANCE");

        Listing memory listing = Listing({
            id: listing_ids.length,
            date: block.timestamp,
            merchant: msg.sender,
            asset: asset,
            amount: amount,
            value: value
        });

        uint id = listings.push(listing) - 1;
        listing_ids.push(id);

        auction_events.listing_created(msg.sender, id);
    }

    // listings
    // merchants -> addresses
    // listings by merchant id => listing
    // events all the things

    /// @notice Utilize the fallback function, send 0 ETH to create a new vault for the merchant
    function () public payable {
        require(msg.value == 0, "VAULT REQUIRES 0 ETH TX");
        require(vaults[msg.sender] == 0x0, "VAULT ALREADY EXISTS");

        vaults[msg.sender] = address(
            new Vault(msg.sender)
        );

        // Vault Creation Event
        auction_events.vault_created(msg.sender, vaults[msg.sender]);
    }
}