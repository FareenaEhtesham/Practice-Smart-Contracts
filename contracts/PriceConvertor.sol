// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

import "./AggregatorInterface.sol";
// import directly from github
//import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

library PriceConvertor{

    function getPrice() internal view returns(uint256){
        // Address
        // Abi
        AggregatorV3Interface priceFeed = AggregatorV3Interface(0x8A753747A1Fa494EC906cE90E9f37563A8AF630e);
        (, int256 answer ,,,) = priceFeed.latestRoundData();
        
        //This function return ETH in terms of USD
        return uint256(answer* 1e10); // 1**10
    }
 
    function getVersion() internal view returns(uint256){

        AggregatorV3Interface priceFeed = AggregatorV3Interface(0x8A753747A1Fa494EC906cE90E9f37563A8AF630e);
        return priceFeed.version();
    }

    function conversion(uint256 ethAmount) internal view returns(uint256){
        // user send an ethereum and here in this function we convert it into dollars
        uint256 ethPrice = getPrice(); // eth ki value in USD
        uint256 ethinUSD = (ethAmount * ethPrice) / 1e18;
        return ethinUSD;

    }
}

/*
As this library embed into contract, so all the functions inside a library must be internal

*/