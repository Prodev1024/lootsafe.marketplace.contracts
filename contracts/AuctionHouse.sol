pragma solidity ^0.4.18;

import "./lib/Cellar.sol";
import "./lib/AuctionEvents.sol";
import "./Vault.sol";

contract AuctionHouse {
    using Cellar for Cellar.Listing;
    AuctionEvents public auctionEvents;

    address public owner;

    mapping (address => address) public vaults;


    /// @notice Utilize the fallback function, send 0 ETH to create a new vault for the merchant
    function () public payable {
        require(msg.value == 0);
        require(vaults[msg.sender] == 0x0);

        vaults[msg.sender] = address(
            new Vault(msg.sender)
        );

        // Vault Creation Event
        auctionEvents.vaultCreated(msg.sender, vaults[msg.sender]);
    }
}