//SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import "./Allowance.sol";

contract SharedWallet is Allowance{

    event MoneySent(address indexed _beneficiary, uint _amt);
    event MoneyRecieved(address indexed _from, uint _amt);

    function withdrawMoney(address payable _to, uint _amount) public ownerOrAllowed(_amount){
        require(_amount <= address(this).balance, "Not Enough Funds in Smart Contract");
        if(owner()!=msg.sender){
            reduceAllowance(_to, _amount);
        }
        _to.transfer(_amount);
        emit MoneySent(_to, _amount);
    } 

    

    function receiveEth() external payable {
        emit MoneyRecieved(msg.sender, msg.value);
    } 
}