pragma solidity ^0.4.24;

import "./lib/Cellar.sol";
import "./lib/MarketEvents.sol";
import "./Vault.sol";

contract Market {
    using Cellar for Cellar.Listing;
    MarketEvents public market_events;

    address public base;
    address public owner;

    Cellar.Listing[] public listings;
    uint listing_count;

    mapping (address => address) public vaults;

    constructor (address _base) public {
        owner = msg.sender;
        base = _base;
        market_events = new MarketEvents();
    }

    // My trades needs to exist

    /// @notice Get all listing ids
    /// @return Uint list of all active listing ids
    function get_listings () external view returns (uint[]) {
        return listing_ids;
    }

    /// @notice Get a listing by id
    /// @return listing... id, date, merchant, asset, amount, value
    function get_listing (uint id) external view returns (uint256, uint256, address, address, uint256, uint256, uint) {
        Cellar.Listing memory listing = listings[id];
        return (
            listing.id,
            listing.date,
            listing.merchant,
            listing.asset,
            listing.amount,
            listing.value,
            listing.status
        );
    }

    /// @notice Get the address of senders vault
    function my_vault () external view returns (address) {
        return (vaults[msg.sender]);
    }

    /// @notice Create a listing on the marketplace
    /// @param asset Address of asset to sell
    /// @param amount Amount of asset to sell
    /// @param value How much to sell asset for
    function create_listing (address asset, uint256 amount, uint256 value) public {
        Vault vault = Vault(vaults[msg.sender]);
        require(vaults[msg.sender] != 0x0, "NO VAULT EXISTS");
        require(vault.has_balance(asset, amount), "INSUFFICIENT VAULT BALANCE");

        Cellar.Listing memory listing = Cellar.Listing({
            id: listing_count,
            date: block.timestamp,
            merchant: msg.sender,
            asset: asset,
            amount: amount,
            value: value,
            status: 0
        });

        vault.lock_asset(asset, amount);

        listing_count++;

        market_events.listing_created(msg.sender, id);
    }

    /// @notice Cancel a listing and unlock assets
    /// @param id Id of listing to cancel
    function cancel_listing (uint id) public {
        Cellar.Listing storage listing = listings[id];
        Vault vault = Vault(vaults[msg.sender]);

        require(listing.status == 0, "LISTING NOT ACTIVE");
        require(msg.sender == listing.merchant, "UNAUTHORIZED MERCHANT");

        vault.unlock_asset(listing.asset, listing.amount);

        listing.status = 2;

        market_events.listing_cancelled(id);
    }

    /// @notice Fulfill a listing and purchase merchants asset
    /// @param id Id of the listing to fulfil
    function fulfill_listing (uint id) public {
        Cellar.Listing storage listing = listings[id];
        require(listing.status == 0, "LISTING NOT ACTIVE");

        Vault vault = Vault(vaults[msg.sender]);
        Vault merchant_vault = Vault(vaults[listing.merchant]);

        require(vaults[msg.sender] != 0x0, "MISSING VAULT");
        require(vault.has_balance(base, listing.value), "INSUFFICIENT FUNDS");

        vault.transfer(listing.merchant, base, listing.value);
        merchant_vault.transfer(msg.sender, listing.asset, listing.amount);
        merchant_vault.unlock_asset(listing.asset, listing.amount);

        listing.status = 1;

        market_events.listing_fulfilled(id, msg.sender);
    }

    /// @notice Utilize the fallback function, send 0 ETH to create a new vault for the merchant
    function () public payable {
        require(msg.value == 0, "VAULT REQUIRES 0 ETH TX");
        require(vaults[msg.sender] == 0x0, "VAULT ALREADY EXISTS");

        vaults[msg.sender] = address(
            new Vault(msg.sender)
        );

        // Vault Creation Event
        market_events.vault_created(msg.sender, vaults[msg.sender]);
    }
}