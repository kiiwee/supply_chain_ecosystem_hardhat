// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

contract CollateralContract {
    uint256 public collateralCost;
    address payable public owner;
    uint private nr_collaterals = 0;
    uint private nr_suppliers = 0;
    uint private transactionNumber;
    
    mapping(address => bool) ecoCheckMade;
    mapping(address => bool) ecoCheckFailedPast;

    //Suppliers
    mapping(address => bool) payedCollateral;
    mapping(address => bool) activeSuppliers;
    mapping(address => uint256) supplierTransactionsPayed;

    event Withdrawal(uint amount, uint when);

    constructor(uint256 cost) payable {
        collateralCost = cost;
        owner = payable(msg.sender);
    }

    modifier manufacturerOnly() {
        require(msg.sender == owner, "Manufacturer reserved only");
        _;
    }
    modifier supplierOnly() {
        require(payedCollateral[msg.sender], "Supplier only");
        _;
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

    
    function payTo(address to, uint256 amount) internal returns (bool) {
        (bool success, ) = payable(to).call{value: amount}("");
        require(success, "Payment failed");
        return true;
    }

    function addSupplier(
        address supplier, 
        uint256 payment
    ) external colcontract.manufacturerOnly returns (bool){
        require (!colcontract.activeSuppliers[supplier], "Supplier already added!");
        require (payment > 0, "Payment must be hiher than 0!");
        colcontract.nr_suppliers ++;
        colcontract.activeSuppliers[supplier] = true;
        colcontract.supplierTransactionsPayed[supplier] = transactionNumber;
        // supplierPaymentAmount[supplier] = amount;  what does "supplierPaymentAmmount" mean?
        return true;

    }
    

}
