// USER REQUIREMENT
// any user can funds 
// only owner can withdraw
// we set a minimum fund value

// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

import "./PriceConvertor.sol";

contract FundMe{

    // call library
    using PriceConvertor for uint256;

    uint256 public constant minimumUsd = 50 * 10 ** 18;
    address public owner;

    //structure of arrays
    address[] public funders;   // array of all the funders jo transactions[FUND] karaingy
    /*SYNTAX
    mapping(keyType => valueType).
    */
    mapping(address => uint256) public fundersAmount;

    constructor(){
        // this function called immediately when contracts get deployed
        owner = msg.sender;   // msg.sender contain the address of the person who deploy this cntract 
    }

    function receiveFunds() public payable{

        /*conversion(msg.value) === msg.value.conversion()
        as conversion function defined in library contains an input

        IF THIS FUNCTION EXPECT 2 INPUTS:
        second parameter would be inside (....)
        msg.value.conversion(123);
        */

        // require is like a check if false so it print The minimum amount of........ 
        require(msg.value.conversion() >= minimumUsd , "The minimum amount of fund would be >=50$");
        funders.push(msg.sender);   // msg.sender is the address of whoever calls the function
        fundersAmount[msg.sender] = msg.value;
        // Now we have to convert (msg.value) which may be in ether to USD
    }

    function withdraw() public onlyOwner{

        // for(startingIndex ; endingIndex ; increment)
        uint256 funderIndex;

        for(funderIndex = 0; funderIndex < funders.length; funderIndex++){

            address funder = funders[funderIndex]; // funderIndex = 0 means our first funder
            fundersAmount[funder] = 0;
        }

        // withdraw a whole balance as logic of for loop

        // 3-ways to sending ether 
        // Transfer
        payable(msg.sender).transfer(address(this).balance);

        //send
        bool success = payable(msg.sender).send(address(this).balance);
        require(success , "Send Failed");

        //call
        (bool successWithdraw, ) = payable(msg.sender).call{
            value: address(this).balance
        }("");
        require(successWithdraw , "Call Failed");
        
    }

    function withdrawSpecificAmount(uint256 amount) public onlyOwner{

        payable(msg.sender).transfer(amount);
    }

    function totalFunds() public onlyOwner view returns(uint){
        return address(this).balance;
    }

    modifier onlyOwner(){
        require(msg.sender == owner, "Only owner can withdraw transactions");
        _;
    }
}


// NOTES

/*blockchain doesnot accept traditional agreements i.e. paypal, visa This is the problem
SOLUTION:

CHAINLINK AND BLOCKCHAIN ORACLE
Chainlink(Connect your contracts to the outside world)
Chainlink Data Feeds are the quickest way to connect your smart contracts to the real-world market prices of assets
Chainlink is a technology enables your contracts to access to any external data source through our decentralized oracle network.


When we make a contract we need 2 things 
ABI
Address

Working with Interfaces gives you an ABI to interact your contract with outside world


*/