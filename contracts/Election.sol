// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

struct Candidate {
    string name;
    uint voteCount;
}
struct Voter {
    bool isRegister;
    bool isVoted;
    uint voteIndex;
}

contract Election{
    address public manager;
    Candidate [] public candidates;
    mapping (address=>Voter) public voter;
    constructor() {
        manager = msg.sender;
    }
    modifier onlyManager{
        require(msg.sender==manager,"Unauthorized.");
        _;
    }
    function addCandidates(string memory name) onlyManager public{
        candidates.push(Candidate(name,0));
    }
    function register(address person) onlyManager public{
        voter[person].isRegister = true;
    }
    function vote(uint index) public{
        require(voter[msg.sender].isRegister,"Registration is required.");
        require(!voter[msg.sender].isVoted,"You already voted.");
        voter[msg.sender].voteIndex = index;
        voter[msg.sender].isVoted == true;
        candidates[index].voteCount += 1;
    }
}

//addresss => 