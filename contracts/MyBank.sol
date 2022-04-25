// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
struct Manager{
    string name;
    uint age;
    address account;

}
contract MyBank {
    uint _balance = 1000;
    Manager public manager;
    constructor(string memory _name,uint _age){
        manager.name = _name;
        manager.age = _age;
        manager.account =  msg.sender;
    }
    function getBalance() public view returns(uint) {
        return _balance;
    }
}