//SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract SharedWallet{

    address public owner;

    constructor(){
       owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "You are not the owner");
        _;
    }

    function withdrawMoney(address payable _to, uint _amount) public {
        _to.transfer(_amount);
    } 
    function receiveEther() external payable {

    }
}