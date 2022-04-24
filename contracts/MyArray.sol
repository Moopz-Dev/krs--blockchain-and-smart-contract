// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
contract MyArray{
    //static array
    uint[3] public numberArr = [100,200,300];
    string[3] public pets = ["cat","dog","bee"];
    //dynamic array
    string[] public partners ;
    address[] public accounts = [0x64E489BF82b8aF1fbd609ECE3b7dadFF2e2380A9,0x16E3B7096463C2ff6789851f5af57990A1f82634];

    function getPartnersCount() public view returns(uint){
        return partners.length;
    }

    function addPartner(string memory _newPartner) public {
        partners.push(_newPartner);
    }
    function changeElement(uint _index,string memory _element) public {
        partners[_index] = _element;
    }
}