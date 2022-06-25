//SPDX-License-Identifier: MIT
pragma solidity 0.8.7; // version of solidity
// any version 0.8.7 or greater is acceptable

//make a contract name SimpleStorage
contract SimpleStorage{
    // Boolean, int, unit, address, bytes
    // bool hasNumber = true;
    // string NumberText = "Five";
    // address myAddress = 0xDdb648CC37553F72B0Af3f02f5089b4e7582C7cE ;
    // int256 Number = -9;
    uint8 public favNo = 1; 
    // bytes32 favouriteByte = "cat"; // convert cat into byte having length 64

    function store(uint8 updatefavNo) public{
        favNo = updatefavNo;
        // execution cost increase
        retrieve();
    }

    // view, pure
    // view means we are just going to read that function or deploy me koi hash
    // bhi generate nahi hota

    // pure 

    function retrieve() public view returns (uint8){
        // as we use view so this function only reads value of favNo
        return favNo;

    }
}



