pragma solidity ^0.8.0;

import "./HoneyPot.sol";

contract HoneyPotAttacker {
    
    function attack(address _honeypot) external payable {
        HoneyPot(_honeypot).withdraw{value : msg.value}();
    }
  
    function getBalance() external view returns (uint) {
        return address(this).balance;
    }
  
    fallback () external payable { }

    receive() external payable {}
}