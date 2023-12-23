// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;

contract Voter {

    struct Candidate {
        string name;
        uint256 votes;
        bool isRegistered;
    }

    mapping(address => uint256) votes;
    mapping(address => Candidate) candidates;
    address[] alreadyVoted;
    address[] candidateAddresses;

    function registerCandidate(string memory candidateName) public {
        require(!candidates[msg.sender].isRegistered, "Kandidat yzhe zaregistrirovan");
        candidates[msg.sender] = Candidate(candidateName, 0, true);
        candidateAddresses.push(msg.sender);
    }

    function vote(address candidateAddress) public returns (uint256) {
        require(candidates[candidateAddress].isRegistered, "Adres nr ykazan kak kandidat");
        require(candidateAddress != msg.sender, "Vi ne mozhete progolosovat za sebya");
        require(!hasAlreadyVoted(msg.sender), "Vi yzhe progolosovali");

        votes[candidateAddress]++;
        alreadyVoted.push(msg.sender);

        return votes[candidateAddress];
    }

    function getCandidates() public view returns (address[] memory) {
        return candidateAddresses;
    }

    function getCandidateName(address candidateAddress) public view returns (string memory) {
        require(candidates[candidateAddress].isRegistered, "Adres nr ykazan kak kandidat");
        return candidates[candidateAddress].name;
    }

    function hasAlreadyVoted(address voter) internal view returns (bool) {
        for (uint256 i = 0; i < alreadyVoted.length; i++) {
            if (alreadyVoted[i] == voter) {
                return true;
            }
        }
        return false;
    }

    function getVotes(address candidateAddress) public view returns (uint256) {
        require(candidates[candidateAddress].isRegistered, "Adres nr ykazan kak kandidat");
        return votes[candidateAddress];
    }
}
