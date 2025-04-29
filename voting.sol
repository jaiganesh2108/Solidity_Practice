// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Voting {
    struct Candidate {
        bytes32 name;
        uint8 voteCount;
    }

    mapping(address => bool) public hasVoted;
    Candidate[] public candidates;

    constructor(bytes32[] memory candidateNames) {
        for (uint i = 0; i < candidateNames.length; i++) {
            candidates.push(Candidate(candidateNames[i], 0));
        }
    }

    function vote(uint8 candidateIndex) external {
        require(!hasVoted[msg.sender], "Already voted.");
        require(candidateIndex < candidates.length, "Invalid candidate.");

        hasVoted[msg.sender] = true;
        candidates[candidateIndex].voteCount += 1;
    }

    function getCandidate(uint8 index) external view returns (bytes32 name, uint8 voteCount) {
        require(index < candidates.length, "Invalid candidate.");
        Candidate storage c = candidates[index];
        return (c.name, c.voteCount);
    }

    function totalCandidates() external view returns (uint256) {
        return candidates.length;
    }
}
