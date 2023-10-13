// // SPDX-License-Identifier: UNLICENSED
// pragma solidity ^0.8.9;

// import "@openzeppelin/contracts/token/ERC1155/extensions/ERC1155URIStorage.sol";
// import "@openzeppelin/contracts/token/ERC1155/extensions/ERC1155Burnable.sol";
// import "@openzeppelin/contracts/token/ERC1155/extensions/ERC1155Supply.sol";
// import "@openzeppelin/contracts/access/AccessControl.sol";

// import "./Token.sol";

// contract CollateralContract {
//     uint256 public collateralCost;
//     address payable public owner;
//     uint private nr_collaterals = 0;
    
//     mapping(address => bool) payedCollateral;


//     constructor(uint256 cost) payable {
//         collateralCost = cost;
//         owner = payable(msg.sender);
//     }

//     function payForCollateral() public payable {
//         require(msg.value == collateralCost, "Paying too much or too little");
//         payedCollateral[msg.sender] = true;
//         nr_collaterals++;
//     }
    
// }

// contract PaySupplierContract is MyToken, {
//     CollateralContract colcontract =CollateralContract();

//     uint256 private toBePayed;
//     address payable public owner;
 
//     uint256 private transactionNumber;
//     mapping(address => uint256) supplierPaymentAmount;


//     constructor(uint256 cost) payable {
//         toBePayed = cost;
//         owner = payable(msg.sender);
//     }

//     function PaySupplier public (address to, uint256 amount) returns (bool){
//          (bool success, ) = payable(to).call{value: amount}("");
//         require(success, "Payment failed");
//         return true;
//     }

//     public function checkMap()  returns (bool) {
//         colcontract.payedCollateral(msg.msg.sender)
//     }

// }

// contract CustomerBuying {

// } 


//     // token transfer
//     // token roles
//     // payment to supplier
//     // multisig
//     // customer buying the product
//     // employees
//     // machine time
//     //
