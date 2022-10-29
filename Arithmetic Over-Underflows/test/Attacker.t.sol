pragma solidity ^0.8.13;

import "../lib/forge-std/src/Test.sol";
import "../src/CallMeMaybe.sol";
import "../src/Attacker.sol";

contract AttackerTest is Test {
    address public callMeMaybe;

    function setUp() public {
        callMeMaybe = new CallMeMaybe();
        vm.deal(callMeMaybe, 10 ether);
    }

    function testAttack() public {
        Attacker attacker = new Attacker(address(callMeMaybe));
        assertEq(address(attacker).balance, 10 ether);
    }
}