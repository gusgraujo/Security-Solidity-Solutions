// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.15;

import "@forge-std/Test.sol";
import "../src/VulnerableMarket.sol";


contract MarketAttackTest is Test {
    VulnerableMarket market;
    address player;

    function setUp() public {
        vm.startPrank(player);
        market = VulnerableMarket(address(100));
        console.logAddress(address(market));
        vm.stopPrank();
    }

    function testAttackMarket() public {
        vm.startPrank(player);
        console.logAddress(player);

        vm.stopPrank();
    }
    


}