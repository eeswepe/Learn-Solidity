// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract TokenSale {
    mapping(address => uint) public balances;
    uint public totalRaised;

    function buyTokens() public payable {
        uint amount = msg.value; 
        balances[msg.sender] += amount;
        totalRaised += amount; 
    }
}