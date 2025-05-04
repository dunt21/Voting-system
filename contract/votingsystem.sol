// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Ownable{
address public  owner;

constructor (){
    owner = msg.sender;
}

modifier onlyOwner (){
    require(owner == msg.sender, "You don't have access");
_;
}
}

contract VotingSystem is Ownable{
struct Candidate{
    uint id;
    string name;
    uint voteCount;
}

uint public id;
uint public  totalCandidates;

mapping(uint => Candidate) public candidates;
mapping(address => bool) public userVoted;

function addCandidate (string calldata name) public onlyOwner{
    string memory candidateName = name;
    candidates[id] = Candidate({id: id, name: candidateName, voteCount: 0});

    id++;
    totalCandidates++;
}

function vote (uint candidateId) public {

require(!userVoted[msg.sender], "You can't vote twice");
require(candidateId < totalCandidates, "Such candidate does not exist");

 candidates[candidateId].voteCount++;

userVoted[msg.sender] = true;
}

function getCandidate(uint candidateId) public  view returns (string memory  name, uint voteCount){
    Candidate memory candidateInfo = candidates[candidateId];
    return (candidateInfo.name, candidateInfo.voteCount);
}

function getTotalCandidates () public view returns (uint){
    return totalCandidates;
}

}