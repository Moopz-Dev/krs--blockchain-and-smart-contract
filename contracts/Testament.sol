// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
contract Testament{

    address _manager;

    //testament owner address => heir address
    mapping(address=>address) _heir;

    //testament owner address => amount
    mapping(address=> uint256) _balance;

    event Create(address indexed owner, address indexed heir, uint amount);
    event Report(address indexed owner, address indexed heir, uint amount);

    constructor(){
        _manager = msg.sender;
    }

    //owner create testament
    function create (address heir) public payable {
        require (msg.value > 0 ,"Can't create empty testament.");
        require ( _balance[msg.sender]<=0, "Your testament already exists.");
        _heir[msg.sender] = heir;
        _balance[msg.sender] = msg.value;
        emit Create(msg.sender,heir,msg.value);
    }
    function getTestament( address owner) public view returns(address heir, uint256 amount) {
        return (_heir[owner],_balance[owner]);
    }
    function reportOfDeath(address owner) public {
        require (msg.sender == _manager, "Only the manager is allowed to use this function. ");
        require (_balance[owner] > 0 , "The testement is empty.");
        emit Report(owner,_heir[owner],_balance[owner]);

        payable(_heir[owner]).transfer(_balance[owner]);
        _balance[owner] = 0;
        _heir[owner] = address(0);
    }
}