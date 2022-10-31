pragma solidity ^0.8.13;

import "../lib/forge-std/src/Test.sol";
import "../src/CallMeMaybe.sol";
import "../src/Attacker.sol";

contract AttackerTest is Test {
    CallMeMaybe callMeMaybe;
    address public attacker;

    function setUp() public {
        vm.startPrank(attacker);
        callMeMaybe = new CallMeMaybe();
        vm.deal(address(callMeMaybe), 10 ether);
        callMeMaybe.hereIsMyNumber();
        vm.stopPrank();
    }

    function testAttack() public {
        assertEq(address(attacker).balance, 10 ether);
    }
}