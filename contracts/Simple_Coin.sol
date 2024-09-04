// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SimpleCoin {

    address public minter;
    mapping(address => uint256) public balances;

    event Sent(address from, address to, uint256 amount);

    constructor(){
        minter = msg.sender;
    }

    function mint(address _receiver, uint256 _amount) public {
        require(msg.sender == minter, "Only sender can mint this coin");
        balances[_receiver] += _amount;
    }

    function send(address _receiver, uint256 _amount) public {
        require(_amount <= balances[msg.sender], "Insufficient Balance");
        balances[msg.sender] -= _amount;
        balances[_receiver] += _amount;
        emit Sent(msg.sender, _receiver, _amount);
    }

}