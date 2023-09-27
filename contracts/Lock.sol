// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

contract Lock {
    uint256 public collateralCost;
    address payable public owner;
    uint private nr_collaterals = 0;
    mapping(address => bool) payedCollateral;
    mapping(address => bool) ecoCheckMade;
    mapping(address => bool) ecoCheckFailedPast;
    event Withdrawal(uint amount, uint when);

    constructor(uint256 cost) payable {
        require(1 < cost, "Unlock time should be in the future");

        collateralCost = cost;
        owner = payable(msg.sender);
    }

    function payForCollateral() public payable {
        require(msg.value == collateralCost, "Paying too much or too little");
        payedCollateral[msg.sender] = true;
        nr_collaterals++;
    }
}
