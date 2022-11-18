pragma solidity ^0.6.0;


import "../lib/forge-std/src/Test.sol";
import "../src/DogGatesAttacker.sol";


contract DogGatesAttackerTest is Test{
    DogGates private gate;
    DogGatesAttacker attacker;
    address private owner = address(100);

    function setUp() public {
        gate = new DogGates();
        attacker = new DogGatesAttacker();
    }

    function testDogGatesAttacker() public
    {
        attacker.hack(address(gate),1000,1000000);
    }

}
