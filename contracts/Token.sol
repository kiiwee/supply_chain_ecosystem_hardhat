// SPDX-License-Identifier: MIT
pragma solidity 0.8.9;
// cid : bafybeifwrdj7ircxzaqkwzacdp3gkcamnhgawmflnyh7lccusd43niyvpu
// IPDS URL : ipfs://bafybeifwrdj7ircxzaqkwzacdp3gkcamnhgawmflnyh7lccusd43niyvpu

import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC1155/extensions/ERC1155Burnable.sol";
import "@openzeppelin/contracts/token/ERC1155/extensions/ERC1155Supply.sol";

contract MyToken is ERC1155, Ownable, ERC1155Burnable, ERC1155Supply {
    uint256 public constant GOLD = 0;
    uint256 public constant DENIMFABRIC = 1;
    uint256 public constant SIEGEBAND = 2;
    uint256 public constant ZIPPER = 3;
    uint256 public constant STITCHINGYARN = 4;
    uint256 public constant PATTERNPAPER = 5;
    uint256 public constant JEANSSEWED = 6;

    constructor()
        ERC1155(
            "ipfs://bafybeifwrdj7ircxzaqkwzacdp3gkcamnhgawmflnyh7lccusd43niyvpu/{id}.json"
        )
    {}

    function setURI(string memory newuri) public onlyOwner {
        _setURI(newuri);
    }

    function mint(uint256 id, uint256 amount) public onlyOwner {
        _mint(msg.sender, id, amount, "");
    }

    function mintBatch(
        uint256[] memory ids,
        uint256[] memory amounts
    ) public onlyOwner {
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
