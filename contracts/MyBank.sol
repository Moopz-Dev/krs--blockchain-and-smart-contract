// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
struct Manager{
    string name;
    uint age;
    address account;

}
contract MyBank {
    enum State {Open,Closed}
    uint _balance = 1000;
    Manager public manager;
    State public bankState = State.Open; 
    constructor(string memory _name,uint _age){
        manager.name = _name;
        manager.age = _age;
        manager.account =  msg.sender;
    }

    modifier isManager{
        require(msg.sender == manager.account,"You don't have permission to use this function.");
        _;    
    }

    function getBalance() public view isManager returns(uint) {
        require(bankState == State.Open,"Service not available, bank is closed.");
        return _balance;
    }
    function getManager() public view isManager returns (string memory ){
        return manager.name;
    }
}