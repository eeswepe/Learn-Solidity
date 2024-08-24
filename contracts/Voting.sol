// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Voting {
    //declaring struct of candidate
    struct Candidate {
        uint256 id;
        string name;
        uint256 voteCount;
    }

    // declaring variables
    address public owner;
    mapping(uint256 => Candidate) public candidates;
    mapping(address => bool) public voters;
    uint256 public candidatesCount;
    uint256 public totalVotes;
    uint256 public votingEndTime;//in seconds

    //setting default value of some variable
    constructor() {
        owner = msg.sender;
        candidatesCount = 0;
        totalVotes = 0;
    }

    //adding event to interact with web3.js
    event CandidateAdded(uint256 id, string name);
    event VoteCast(address indexed sender, uint256 candidateId);

    //adding onlyowner modifier 
    modifier OnlyOwner(){
        require(msg.sender == owner, "You are not the owner");
        _;
    }
    //adding votingperiod modifier
    modifier onlyDuringVoting () {
        require(block.timestamp < votingEndTime, "Voting period has ended.");
        _;
    }

    //setting voting period
    function setVotingPeriod(uint256 _duration) public OnlyOwner {
        votingEndTime = block.timestamp + _duration;
    }

    //function to add candidates
    function addCandidate(string memory _name) public OnlyOwner{
        candidatesCount++;
        candidates[candidatesCount] = Candidate(candidatesCount, _name, 0);
        emit CandidateAdded(candidatesCount, _name);
    }

    //function to vote candidate
    function vote(uint256 _candidateId) public onlyDuringVoting{
        require(!voters[msg.sender], "You have already voted.");
        require(_candidateId > 0 && _candidateId <= candidatesCount, "Invalid candidate ID.");

        candidates[_candidateId].voteCount++;
        totalVotes++;
        voters[msg.sender] = true;
        emit VoteCast(msg.sender, _candidateId);
    }

    //function to get candidate vote
    function getVotes(uint256 _candidateId) public view returns(uint256){
        require(_candidateId > 0 && _candidateId <= candidatesCount, "Invalid candidate ID.");
        return candidates[_candidateId].voteCount;
    }

    //function to get all candidates
    function getCandidates() public view returns(Candidate[] memory){
        Candidate[] memory candidateList = new Candidate[](candidatesCount);
        for (uint256 i = 1; i <= candidatesCount; i++) {
            candidateList[i - 1] = candidates[i];
        }
        return candidateList;
    }
}