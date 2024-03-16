// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract VotingContract {
    struct Option {
        string name;
        uint256 voteCount;
    }

    Option[] public options;

    constructor() {
        options.push(Option("singgih", 0));
        options.push(Option("wahyu", 0));
        options.push(Option("permana", 0));
    }

    function voteForOption(uint256 optionIndex) public {
        require(optionIndex < options.length, "Invalid option index");
        options[optionIndex].voteCount += 1;
    }

    function getVote(uint256 optionIndex) public view returns (uint256) {
        require(optionIndex < options.length, "Invalid option index");
        return options[optionIndex].voteCount;
    }
}
