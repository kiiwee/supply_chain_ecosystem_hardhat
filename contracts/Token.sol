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

/**************************************** */

contract CollateralContract {
    uint256 public collateralCost;
    address payable public owner;
    uint private nr_collaterals = 0;

    mapping(address => bool) public payedCollateral;

    constructor(uint256 cost) payable {
        collateralCost = cost;
        owner = payable(msg.sender);
    }

    function payForCollateral() public payable {
        require(msg.value == collateralCost, "Paying too much or too little");
        payedCollateral[msg.sender] = true;
        nr_collaterals++;
    }

    function payTo(address to, uint256 amount) public returns (bool) {
        require(amount > 0, "Payment must be greater than zero!");
        (bool success, ) = payable(to).call{value: amount}("");
        require(success, "Payment failed");
        return true;
    }
}

contract ProductTransferContract is MyToken {
    uint256 public rawMaterialCost;
    address payable public owner;

    //MyToken myToken = MyToken();
    CollateralContract collateralContract;

    constructor(uint256 cost, uint256 costCollateral) payable {
        rawMaterialCost = cost;
        collateralContract = new CollateralContract{value: costCollateral}(
            costCollateral
        ); // Deploy CollateralContract with value
        // myToken = new MyToken();
        owner = payable(msg.sender);
    }

    function expectRawMaterials(
        address from,
        uint256 productId,
        uint256 howMuch
    ) public payable returns (bool) {
        require(
            collateralContract.payedCollateral[from],
            "The supplier has not paid the collateral"
        ); // Check if the supplier (from) has paid the collateral.
        normal_mint(productId, howMuch); // Mint the specified quantity of items.
        _safeTransferFrom(from, msg.sender, productId, howMuch, ""); // Transfer the minted items from the supplier (from) to the manufacturer (msg.sender).
        require(
            collateralContract.payTo(from, rawMaterialCost),
            "Payment to supplier failed"
        ); // Make a payment to the supplier (from).

        return true;
    } //function supposedly called by the manufacturer ("from" is the address of the supplier)
}

contract PayAsCustomerContract is MyToken {
    uint256 public productCost;
    address payable public owner;
    CollateralContract collateralContract = CollateralContract();

    //ProductTransferContract productTransferContract = ProductTransferContract();

    constructor(uint256 costCollateral) payable {
        // productCost = cost;
        // productTransferContract = new ProductTransferContract(rawProductCost,costCollateral);
        owner = payable(msg.sender);
        collateralContract = new CollateralContract(costCollateral);
    }

    function buyItem(
        address from,
        uint256 productId
    ) public payable returns (bool) {
        require(collateralContract.payTo(from, productCost), "Payment failed");
        _safeTransferFrom(from, msg.sender, productId, 1, ""); // "1" becasue we transfer only one instance of the finalised product.

        return true;
    }
}

// contract ManagementContract is ProductTransferContract, PayAsCustomerContract {
//     // You can add additional functions and variables specific to ManagementContract here.

//     constructor(uint256 rawMaterialCost, uint256 productCost) {
//         // Initialize the rawMaterialCost and productCost
//         rawMaterialCost = rawMaterialCost;
//         productCost = productCost;
//     }

//     function expectRawMaterials(
//         address from,
//         uint256 productId,
//         uint256 howMuch
//     ) public payable returns (bool) {
//         require(
//             payedCollateral[from],
//             "The supplier has not paid the collateral"
//         ); // Check if the supplier (from) has paid the collateral.
//         normal_mint(productId, howMuch); // Mint the specified quantity of items.
//         _safeTransferFrom(from, msg.sender, productId, howMuch, ""); // Transfer the minted items from the supplier (from) to the manufacturer (msg.sender).
//         require(payTo(from, rawMaterialCost), "Payment to supplier failed"); // Make a payment to the supplier (from).

//         return true;
//     } //function supposedly called by the manufacturer ("from" is the address of the supplier)

//     function buyItem(
//         address from,
//         uint256 productId
//     ) public payable returns (bool) {
//         require(payTo(from, productCost), "Payment failed");
//         _safeTransferFrom(from, msg.sender, productId, 1, ""); // "1" becasue we transfer only one instance of the finalised product.

//         return true;
//     }
// }
