//SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/math/SafeMath.sol";


contract Allowance is Ownable{

    using SafeMath for uint;
    mapping(address => uint) allowance;

    event AllowanceChanged(address indexed __forWho, address indexed _changedBy, uint _oldAmt, uint _newAmt);

    modifier ownerOrAllowed(uint _amount){
        require(owner()==msg.sender||allowance[msg.sender]>=_amount, "You are now allowed");
        _;
    } 

    function reduceAllowance(address _whose, uint _amount) internal {
        
        
        emit AllowanceChanged(_whose, msg.sender, allowance[_whose], allowance[_whose].sub(_amount));

        allowance[_whose] = allowance[_whose].sub(_amount);
    }

    function addAllowance(address _who, uint _amount) public onlyOwner{
        emit AllowanceChanged(_who, msg.sender, allowance[_who], _amount);
        allowance[_who] = _amount;
    } 

    function checkAllowance(address _whose) public view returns(uint){
        return allowance[_whose];
    }
}