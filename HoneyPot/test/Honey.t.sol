pragma solidity >=0.8.0;

import "../lib/forge-std/src/Test.sol";
import "../src/HoneyPot.sol" ;
import "../src/HoneyPotAttacker.sol" ;


contract HoneyPotTest is Test {
    HoneyPot _honeyPot;
    HoneyPotAttacker _honeyPotAtt;

    function setUp() public {
        _honeyPot = new HoneyPot();
        _honeyPotAtt = new HoneyPotAttacker();
        vm.deal(address(_honeyPot), 10 ether);
    }

    function testAttackHoneyPot() public{
        _honeyPotAtt.attack{value: 32 wei}(address(_honeyPot));
        assertEq(_honeyPotAtt.getBalance(), 10 ether + 32 wei);

    }
}