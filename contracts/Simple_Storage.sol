// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SimpleStorage {

    //declating some variable
    uint256 public number;
    string public message;
    address public owner;
    address[] public visitor;
    
    //declaring event (used to interact with web3.js)
    event NumberStored (address indexed sender, uint256 _number);
    event MessageStored (address indexed sender, string _message);
    
    //constructor (to set default variable value)
    constructor() {
        owner = msg.sender;
    }   

    //creating modifier so only owner can use that function
    modifier OnlyOwner() {
        require(msg.sender == owner, "You are not the owner");
        _;
    }

    //function to set number value
    function setNum(uint256 _number) public OnlyOwner {
        number = _number;
        emit NumberStored(msg.sender, _number);
    }

    //function to set message value
    function setMessage(string memory _message) public OnlyOwner {
        message = _message;
        emit MessageStored(msg.sender, _message);
    }  

    //function to get number value
    function getNum() public view returns(uint256){
        return number;
    }

    //function to get message value
    function getMessage() public view returns(string memory){
        return message;
    }

    //function to set who ever leave their footprint
    function leaveFootprint() public {
        for (uint i = 0; i < visitor.length; i++) {
            if (visitor[i] == msg.sender) {
                return;
            }
        }
        visitor.push(msg.sender);
    }

    //accessing all of visitors
    function getVisitors() public view returns (address[] memory) {
        return visitor;
    }

}