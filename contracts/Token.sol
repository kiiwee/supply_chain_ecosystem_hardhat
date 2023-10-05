// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;
// cid : bafybeifwrdj7ircxzaqkwzacdp3gkcamnhgawmflnyh7lccusd43niyvpu
// IPDS URL : ipfs://bafybeifwrdj7ircxzaqkwzacdp3gkcamnhgawmflnyh7lccusd43niyvpu

import "@openzeppelin/contracts/token/ERC1155/extensions/ERC1155URIStorage.sol";
import "@openzeppelin/contracts/token/ERC1155/extensions/ERC1155Burnable.sol";
import "@openzeppelin/contracts/token/ERC1155/extensions/ERC1155Supply.sol";
import "@openzeppelin/contracts/access/AccessControl.sol";

contract MyToken is
    ERC1155URIStorage,
    AccessControl,
    ERC1155Burnable,
    ERC1155Supply
{
    bytes32 public constant URI_SETTER_ROLE = keccak256("URI_SETTER_ROLE");
    bytes32 public constant MINTER_ROLE = keccak256("MINTER_ROLE");

    uint256 public constant DENIMFABRIC = 1;
    uint256 public constant SIEGEBAND = 2;
    uint256 public constant ZIPPER = 3;
    uint256 public constant STITCHINGYARN = 4;
    uint256 public constant PATTERNPAPER = 5;
    uint256 public constant JEANSSEWED = 6;

    function supportsInterface(
        bytes4 interfaceId
    ) public view virtual override(ERC1155, AccessControl) returns (bool) {
        return super.supportsInterface(interfaceId);
    }

    constructor()
        ERC1155(
            "ipfs://bafybeifwrdj7ircxzaqkwzacdp3gkcamnhgawmflnyh7lccusd43niyvpu/{id}.json"
        )
    {
        _grantRole(DEFAULT_ADMIN_ROLE, msg.sender);
        _grantRole(URI_SETTER_ROLE, msg.sender);
        _grantRole(MINTER_ROLE, msg.sender);
    }

    function uri_set_mint(
        uint256 id,
        uint256 amount,
        string memory tokenURI
    ) public onlyRole(MINTER_ROLE) {
        ERC1155URIStorage._setURI(id, tokenURI);
        _mint(msg.sender, id, amount, "");
    }

    function normal_mint(
        uint256 id,
        uint256 amount
    ) public onlyRole(MINTER_ROLE) {
        _mint(msg.sender, id, amount, "");
    }

    function uri(
        uint256 tokenId
    ) public view override(ERC1155, ERC1155URIStorage) returns (string memory) {
        return ERC1155URIStorage.uri(tokenId);
    }

    function mintBatch(
        uint256[] memory ids,
        uint256[] memory amounts
    ) public onlyRole(MINTER_ROLE) {
        _mintBatch(msg.sender, ids, amounts, "");
    }

    // The following functions are overrides required by Solidity.

    function _beforeTokenTransfer(
        address operator,
        address from,
        address to,
        uint256[] memory ids,
        uint256[] memory amounts,
        bytes memory data
    ) internal override(ERC1155, ERC1155Supply) {
        super._beforeTokenTransfer(operator, from, to, ids, amounts, data);
    }
}
