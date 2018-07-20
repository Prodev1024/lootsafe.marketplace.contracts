* [AuctionHouse](#auctionhouse)
  * [fulfil_listing](#function-fulfil_listing)
  * [listing_ids](#function-listing_ids)
  * [create_listing](#function-create_listing)
  * [base](#function-base)
  * [my_vault](#function-my_vault)
  * [get_listings](#function-get_listings)
  * [owner](#function-owner)
  * [vaults](#function-vaults)
  * [listings](#function-listings)
  * [cancel_listing](#function-cancel_listing)
  * [get_listing](#function-get_listing)
  * [auction_events](#function-auction_events)
* [Vault](#vault)
  * [withdrawal](#function-withdrawal)
  * [parent](#function-parent)
  * [lock_asset](#function-lock_asset)
  * [ether_saver](#function-ether_saver)
  * [has_balance](#function-has_balance)
  * [unlock_asset](#function-unlock_asset)
  * [merchant](#function-merchant)
  * [transfer](#function-transfer)
* [AuctionEvents](#auctionevents)
  * [listing_created](#function-listing_created)
  * [auction_house](#function-auction_house)
  * [vault_created](#function-vault_created)
  * [VaultCreated](#event-vaultcreated)
  * [ListingCreated](#event-listingcreated)
* [Cellar](#cellar)
* [EIP20Interface](#eip20interface)
  * [approve](#function-approve)
  * [totalSupply](#function-totalsupply)
  * [transferFrom](#function-transferfrom)
  * [balanceOf](#function-balanceof)
  * [transfer](#function-transfer)
  * [allowance](#function-allowance)
  * [Transfer](#event-transfer)
  * [Approval](#event-approval)

# AuctionHouse


## *function* fulfil_listing

AuctionHouse.fulfil_listing(id) `nonpayable` `212eff5e`


Inputs

| **type** | **name** | **description** |
|-|-|-|
| *uint256* | id | undefined |


## *function* listing_ids

AuctionHouse.listing_ids() `view` `289aa130`


Inputs

| **type** | **name** | **description** |
|-|-|-|
| *uint256* |  | undefined |


## *function* create_listing

AuctionHouse.create_listing(asset, amount, value) `nonpayable` `389b0dc4`

**Create a listing on the marketplace**


Inputs

| **type** | **name** | **description** |
|-|-|-|
| *address* | asset | Address of asset to sell |
| *uint256* | amount | Amount of asset to sell |
| *uint256* | value | How much to sell asset for |


## *function* base

AuctionHouse.base() `view` `5001f3b5`





## *function* my_vault

AuctionHouse.my_vault() `view` `5b680349`

**Get the address of senders vault**





## *function* get_listings

AuctionHouse.get_listings() `view` `65c4c884`

**Get all listing ids**




Outputs

| **type** | **name** | **description** |
|-|-|-|
| *uint256[]* |  | undefined |

## *function* owner

AuctionHouse.owner() `view` `8da5cb5b`





## *function* vaults

AuctionHouse.vaults() `view` `a622ee7c`


Inputs

| **type** | **name** | **description** |
|-|-|-|
| *address* |  | undefined |


## *function* listings

AuctionHouse.listings() `view` `de74e57b`


Inputs

| **type** | **name** | **description** |
|-|-|-|
| *uint256* |  | undefined |


## *function* cancel_listing

AuctionHouse.cancel_listing(id) `nonpayable` `e4e0dd77`

**Cancel a listing and unlock assets**


Inputs

| **type** | **name** | **description** |
|-|-|-|
| *uint256* | id | id of listing to cancel |


## *function* get_listing

AuctionHouse.get_listing(id) `view` `fed69702`

**Get a listing by id**


Inputs

| **type** | **name** | **description** |
|-|-|-|
| *uint256* | id | undefined |

Outputs

| **type** | **name** | **description** |
|-|-|-|
| *uint256* |  | undefined |
| *uint256* |  | undefined |
| *address* |  | undefined |
| *address* |  | undefined |
| *uint256* |  | undefined |
| *uint256* |  | undefined |

## *function* auction_events

AuctionHouse.auction_events() `view` `fffab44d`







---
# Vault


## *function* withdrawal

Vault.withdrawal(asset, value) `nonpayable` `5a6b26ba`

**Allow withdraw of non-locked funds**


Inputs

| **type** | **name** | **description** |
|-|-|-|
| *address* | asset | The asset the merchant want's to withdraw |
| *uint256* | value | The amount of asset to be transferred |


## *function* parent

Vault.parent() `view` `60f96a8f`





## *function* lock_asset

Vault.lock_asset(asset, amount) `nonpayable` `69fb03b5`

**Lock assets from withdraw**


Inputs

| **type** | **name** | **description** |
|-|-|-|
| *address* | asset | Address of asset to be locked up |
| *uint256* | amount | Amount of asset to lock up |


## *function* ether_saver

Vault.ether_saver() `nonpayable` `760c84fd`

**redeem accidental ETH sent to the contract**





## *function* has_balance

Vault.has_balance(asset, value) `nonpayable` `870d0b84`

**Check balances of assets**


Inputs

| **type** | **name** | **description** |
|-|-|-|
| *address* | asset | Address of asset to check balance of |
| *uint256* | value | Value expected to have |


## *function* unlock_asset

Vault.unlock_asset(asset, amount) `nonpayable` `a48cb6d7`

**Unlock assets from withdraw**


Inputs

| **type** | **name** | **description** |
|-|-|-|
| *address* | asset | Address of asset to be unlocked |
| *uint256* | amount | Amount of asset to unlocked |


## *function* merchant

Vault.merchant() `view` `a5ff7651`





## *function* transfer

Vault.transfer(to, asset, value) `nonpayable` `beabacc8`

**Allow the creator to run transfers of assets**


Inputs

| **type** | **name** | **description** |
|-|-|-|
| *address* | to | The address to transfer to |
| *address* | asset | The asset to transfer |
| *uint256* | value | The amount of asset to be transferred |



---
# AuctionEvents


## *function* listing_created

AuctionEvents.listing_created(merchant, id) `nonpayable` `9448875f`


Inputs

| **type** | **name** | **description** |
|-|-|-|
| *address* | merchant | undefined |
| *uint256* | id | undefined |


## *function* auction_house

AuctionEvents.auction_house() `view` `d440deda`





## *function* vault_created

AuctionEvents.vault_created(merchant, vault) `nonpayable` `db5bca90`


Inputs

| **type** | **name** | **description** |
|-|-|-|
| *address* | merchant | undefined |
| *address* | vault | undefined |

## *event* VaultCreated

AuctionEvents.VaultCreated(merchant, vault) `5d9c31ff`

Arguments

| **type** | **name** | **description** |
|-|-|-|
| *address* | merchant | not indexed |
| *address* | vault | not indexed |

## *event* ListingCreated

AuctionEvents.ListingCreated(merchant, id) `f060b874`

Arguments

| **type** | **name** | **description** |
|-|-|-|
| *address* | merchant | not indexed |
| *uint256* | id | not indexed |


---
# Cellar


---
# EIP20Interface


## *function* approve

EIP20Interface.approve(_spender, _value) `nonpayable` `095ea7b3`

**`msg.sender` approves `_spender` to spend `_value` tokens**


Inputs

| **type** | **name** | **description** |
|-|-|-|
| *address* | _spender | The address of the account able to transfer the tokens |
| *uint256* | _value | The amount of tokens to be approved for transfer |

Outputs

| **type** | **name** | **description** |
|-|-|-|
| *bool* | success | undefined |

## *function* totalSupply

EIP20Interface.totalSupply() `view` `18160ddd`





## *function* transferFrom

EIP20Interface.transferFrom(_from, _to, _value) `nonpayable` `23b872dd`

**send `_value` token to `_to` from `_from` on the condition it is approved by `_from`**


Inputs

| **type** | **name** | **description** |
|-|-|-|
| *address* | _from | The address of the sender |
| *address* | _to | The address of the recipient |
| *uint256* | _value | The amount of token to be transferred |

Outputs

| **type** | **name** | **description** |
|-|-|-|
| *bool* | success | undefined |

## *function* balanceOf

EIP20Interface.balanceOf(_owner) `nonpayable` `70a08231`


Inputs

| **type** | **name** | **description** |
|-|-|-|
| *address* | _owner | The address from which the balance will be retrieved |

Outputs

| **type** | **name** | **description** |
|-|-|-|
| *uint256* | balance | undefined |

## *function* transfer

EIP20Interface.transfer(_to, _value) `nonpayable` `a9059cbb`

**send `_value` token to `_to` from `msg.sender`**


Inputs

| **type** | **name** | **description** |
|-|-|-|
| *address* | _to | The address of the recipient |
| *uint256* | _value | The amount of token to be transferred |

Outputs

| **type** | **name** | **description** |
|-|-|-|
| *bool* | success | undefined |

## *function* allowance

EIP20Interface.allowance(_owner, _spender) `nonpayable` `dd62ed3e`


Inputs

| **type** | **name** | **description** |
|-|-|-|
| *address* | _owner | The address of the account owning tokens |
| *address* | _spender | The address of the account able to transfer the tokens |

Outputs

| **type** | **name** | **description** |
|-|-|-|
| *uint256* | remaining | undefined |
## *event* Transfer

EIP20Interface.Transfer(_from, _to, _value) `ddf252ad`

Arguments

| **type** | **name** | **description** |
|-|-|-|
| *address* | _from | indexed |
| *address* | _to | indexed |
| *uint256* | _value | not indexed |

## *event* Approval

EIP20Interface.Approval(_owner, _spender, _value) `8c5be1e5`

Arguments

| **type** | **name** | **description** |
|-|-|-|
| *address* | _owner | indexed |
| *address* | _spender | indexed |
| *uint256* | _value | not indexed |


---