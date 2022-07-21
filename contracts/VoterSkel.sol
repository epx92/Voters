pragma solidity ^0.8.13;

struct Ballot{
    string issue;
    uint8 vote1;
    uint8 vote2;
    uint8 vote3;
    address [] PartiesAssoc;
    bool pending;
}

contract voterIssues{

    mapping (uint256 => Ballot) public ballots;

    uint256 ballotCount;
    uint256[] finishedBallotIDs;

    function createBallot(string memory issues) public {

        Ballot storage ballot = ballots[ballotCount];

        ballot.issue = issues;
        ballot.PartiesAssoc.push(msg.sender);
        ballot.vote1 = 0;
        ballot.vote2 = 0;
        ballot.vote3 = 0;
        ballot.pending = true;

        ballotCount += 1;
    }

    function showNextBallot() view external returns(uint256 idx, string memory issx) {
        for (uint256 i = 0; i <= ballotCount; i++){
            Ballot storage ballot = ballots[i];
            for (uint y = 0; y <= ballot.PartiesAssoc.length; y++){
                require(ballot.PartiesAssoc[y] != msg.sender);
            if (ballot.vote1 == 0 || ballot.vote2 == 0 || ballot.vote1 == 0){
                return(
                    i,
                    ballot.issue);
                }
            }
        }
    }

    function vote(uint256 bidx, uint8 choice) public {
        Ballot storage ballot = ballots[bidx];
        require(ballot.vote1 == 0 || ballot.vote2 == 0 || ballot.vote1 == 0);
        for (uint y = 0; y <= ballot.PartiesAssoc.length; y++){
                require(ballot.PartiesAssoc[y] != msg.sender);
        }
        if (ballot.vote1 != 0 && ballot.vote2 != 0 && ballot.vote1 != 0){
            ballot.pending = false;
        }

        for (uint256 i = 0; i < 1; i++){
            if (ballot.vote1 == i && ballot.pending == true){
                ballot.vote1 = choice;
                ballot.PartiesAssoc.push(msg.sender);
                break;
            }
            if (ballot.vote2 == i && ballot.pending == true) {
                ballot.vote2 = choice;
                ballot.PartiesAssoc.push(msg.sender);
                break;
            }
            
            if (ballot.vote3 == i && ballot.pending == true) {
                ballot.vote3 = choice;
                ballot.PartiesAssoc.push(msg.sender);
                break;
            }
        if (ballot.vote1 != 0 && ballot.vote2 != 0 && ballot.vote1 != 0){
            ballot.pending = false;
        }
    }
    }

    function viewBallot (uint256 balID) view external returns(string memory is5ue, uint256 votes1, uint256 votes2, uint256 votes3, bool torf){
        Ballot storage ballot = ballots[balID];

        return(
            ballot.issue,
            ballot.vote1,
            ballot.vote2,
            ballot.vote3,
            ballot.pending
        );
    }
}

