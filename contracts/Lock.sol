// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

contract CollateralContract {
    uint256 public collateralCost;
    address payable public owner;
    uint private nr_collaterals = 0;
    mapping(address => bool) payedCollateral;
    mapping(address => bool) ecoCheckMade;
    mapping(address => bool) ecoCheckFailedPast;
    event Withdrawal(uint amount, uint when);

    constructor(uint256 cost) payable {
        collateralCost = cost;
        owner = payable(msg.sender);
    }

    function payForCollateral() public payable {
        require(msg.value == collateralCost, "Paying too much or too little");
        payedCollateral[msg.sender] = true;
        nr_collaterals++;
    }
}

contract PaymentsContract {
    CollateralContract colcontract =CollateralContract();


    constructor() {};

    public function checkMap()  returns (bool) {
        colcontract.payedCollateral(msg.msg.sender)
    };
}
