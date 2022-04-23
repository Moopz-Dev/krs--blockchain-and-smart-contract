// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
contract MyContract{

//defining variable

address public owner = 0x64E489BF82b8aF1fbd609ECE3b7dadFF2e2380A9;
address public account;

constructor(){
    account = msg.sender;
}
function changeAccount()public{
    account = msg.sender;
}
}