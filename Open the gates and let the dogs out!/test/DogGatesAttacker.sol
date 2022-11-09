
pragma solidity ^0.6.0;


import "../lib/forge-std/src/Test.sol";
import "../src/DogGates.sol";


contract DogGatesAttacker is Test{
    DogGates private gate;
    address private owner = address(100);

    function setUp() public {
        gate = new DogGates();
    }

    function testDogGatesAttacker() public
    {
        vm.startPrank(owner);
        // calculate the key needed to solve the third gate
        bytes8 key = bytes8(uint64(uint160(address(owner)))) & 0xFFFFFFFF0000FFFF;
        gate.enter{gas: 802929}(key);
        
        assertEq(gate.entrant(), owner);

        vm.stopPrank();
    }

}
