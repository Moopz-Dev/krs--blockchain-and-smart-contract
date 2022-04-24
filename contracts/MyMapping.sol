// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
contract MyMapping{
    //  balance of each address
    mapping(address=>uint) public balance;
    function deposit() payable public{
        balance[msg.sender] = msg.value;
    }

}