// USER REQUIREMENT
// any user can funds 
// only owner can withdraw
// we set a minimum fund value

// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

import "./AggregatorInterface.sol";
// import directly from github
//import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

contract FundMe{

    uint256 public minimumUsd = 50;
    address payable public owner;

    AggregatorV3Interface internal priceFeed;

    //structure of arrays
    address[] public funders;   // array of all the funders jo transactions[FUND] karaingy
    mapping(address => uint256) public fundersAmount;

    constructor(){
        // kovan network address
        priceFeed = AggregatorV3Interface(0x9326BFA02ADD2366b30bacB125260Af641031331);
    }

    function receiveFunds() public payable{

        // require is like a check if false so it print The minimum amount of........ 
        require(conversion(msg.value) >= minimumUsd , "The minimum amount of fund would be >=50$");
        funders.push(msg.sender);   // msg.sender is the address of whoever calls the function
        fundersAmount[msg.sender] = msg.value;
        // Now we have to convert (msg.value) which may be in ether to USD
    }

    function getPrice() public view returns(uint256){
        // Address
        // Abi
        (, int256 answer ,,,) = priceFeed.latestRoundData();
        
        //This function return ETH in terms of USD
        return uint256(answer* 1e10); // 1**10
    }

    function getVersion() public view returns(uint256){

        return priceFeed.version();
    }

    function conversion(uint256 ethAmount) public view returns(uint256){
        // user send an ethereum and here in this function we convert it into dollars
        uint256 ethPrice = getPrice(); // eth ki value in USD
        uint256 ethinUSD = (ethAmount * ethPrice) / 1e18;
        return ethinUSD;

    }

    function withdraw(uint256 amount) private{
        require(msg.sender == owner, "Only owner can withdraw transactions");
        payable(msg.sender).transfer(amount);
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