// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Lottery{
    address public manager;
    address payable [] public players;

    constructor(){
        manager = msg.sender;
    }
    function getBalance() public view returns (uint256 ){
        return address(this).balance;
    }
    function buyLottery() public payable{
        require(msg.value == 1 ether,"Please buy lottery at the price of 1 ETH.");
        players.push( payable(msg.sender));

    }
    function getLength() public view returns (uint){
        return players.length;
    }
    function randomNumber() public view returns(uint){
        return uint(keccak256(abi.encodePacked(block.difficulty,block.timestamp,players.length)));
    } 
    function selectWinner()  public {
        require(msg.sender == manager, "Unauthorized.");
        require(getLength()>=2,"Less than 2 players.");
        uint pickrandom = randomNumber();
        address payable winner;
        uint winnerIndex = pickrandom % players.length;
        winner = players[winnerIndex];
        winner.transfer(getBalance());
        players = new address payable[](0);
    }
}   