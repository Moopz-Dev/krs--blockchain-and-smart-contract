// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
contract MyStorage{
    string[] public capital = ["Bangkok","Hanoi"];
    function capitalMemory() public {
        string[] memory newArr = capital;
        newArr[0] = "Rayong";
    }
    function capitalStorage() public {
        string[] storage newArr = capital;
        newArr[0] = "Rayong";
    }
}