// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

contract Receive_Fallback{

    bool public functionCalled = false;

    /*
    receive function(Special function in blockchain) get triggererd every time 
    when some one send ether without actually calls the function.

    if our call data is blank then receive function triggered
    if our call data contain an address then fallback function triggered

    */
    receive() external payable{

        functionCalled = true;

    }

    fallback() external payable{

        functionCalled = true;
    }

        // Explainer from: https://solidity-by-example.org/fallback/
    // Ether is sent to contract
    //      is msg.data empty?
    //          /   \ 
    //         yes  no
    //         /     \
    //    receive()?  fallback() 
    //     /   \ 
    //   yes   no
    //  /        \
    //receive()  fallback()
}