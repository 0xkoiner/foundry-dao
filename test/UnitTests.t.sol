// SPDX-License-Identifier:MIT

pragma solidity 0.8.28;

import {Test, console} from "forge-std/Test.sol";
import {Box} from "src/Box.sol";
import {TimeLock} from "src/TimeLock.sol";
import {TokenDao} from "src/TokenDao.sol";
import {VoteToken} from "src/VotingToken.sol";

contract UnitTests is Test {
    Box box;
    TimeLock timeLock;
    TokenDao tokenDao;
    VoteToken voteToken;

    address public USER = makeAddr("USER");
    uint256 public STRAT_AMOUNT_OF_VOTING_TOKENS = 100 ether;
    uint256[] public VALUES;
    bytes[] public CALLDATA;
    address[] public TARGETS;

    uint256 public constant MINIMUM_DELAY = 3600;
    uint256 public constant VOTING_DELAY = 1;
    uint256 public constant ONE_WEEK = 50400;

    address public ADDRESS1 = makeAddr("ADDRESS1");
    address public ADDRESS2 = makeAddr("ADDRESS2");
    address public ADDRESS3 = makeAddr("ADDRESS3");
    address public ADDRESS4 = makeAddr("ADDRESS4");

    address public EXECUTOR1 = makeAddr("EXECUTOR1");
    address public EXECUTOR2 = makeAddr("EXECUTOR2");
    address public EXECUTOR3 = makeAddr("EXECUTOR3");
    address public EXECUTOR4 = makeAddr("EXECUTOR4");

    address[] public proposers = [ADDRESS1, ADDRESS2, ADDRESS3, ADDRESS4];
    address[] public executors = [EXECUTOR1, EXECUTOR2, EXECUTOR3, EXECUTOR4];

    function setUp() public {
        voteToken = new VoteToken();
        voteToken.mint(USER, STRAT_AMOUNT_OF_VOTING_TOKENS);

        vm.startPrank(USER);
        voteToken.delegate(USER);

        timeLock = new TimeLock(MINIMUM_DELAY, proposers, executors);

        tokenDao = new TokenDao(voteToken, timeLock);

        bytes32 proposerRole = timeLock.PROPOSER_ROLE();
        bytes32 executorRole = timeLock.EXECUTOR_ROLE();
        bytes32 adminRole = timeLock.DEFAULT_ADMIN_ROLE();

        timeLock.grantRole(proposerRole, address(tokenDao));
        timeLock.grantRole(executorRole, address(0));
        timeLock.grantRole(adminRole, USER);

        vm.stopPrank();

        box = new Box();

        box.transferOwnership(address(timeLock));
    }

    function testCantUpdateBoxWithoutGovernance() public {
        vm.expectRevert();
        box.store(1);
    }

    function testGovernanceUpdateBox() public {
        uint256 valueToUpdate = 888;
        string memory description = "Update Store in Box";
        bytes memory encodedFunctionCall = abi.encodeWithSignature(
            "store(uint256)",
            valueToUpdate
        );
        VALUES.push(0);
        CALLDATA.push(encodedFunctionCall);
        TARGETS.push(address(box));

        uint256 proposalID = tokenDao.propose(
            TARGETS,
            VALUES,
            CALLDATA,
            description
        );

        console.log("Proposal State:", uint256(tokenDao.state(proposalID)));

        vm.warp(block.timestamp + VOTING_DELAY + 10);
        vm.roll(block.number + VOTING_DELAY + 10);

        console.log("Proposal State:", uint256(tokenDao.state(proposalID)));

        string memory reason = "i love DAO";

        vm.startPrank(USER);
        tokenDao.castVoteWithReason(proposalID, uint8(1), reason);
        vm.stopPrank();

        vm.warp(block.timestamp + ONE_WEEK + 10);
        vm.roll(block.number + ONE_WEEK + 10);

        bytes32 descriptionHash = keccak256(abi.encodePacked(description));
        tokenDao.queue(TARGETS, VALUES, CALLDATA, descriptionHash);

        vm.warp(block.timestamp + MINIMUM_DELAY + 10);
        vm.roll(block.number + MINIMUM_DELAY + 10);

        tokenDao.execute(TARGETS, VALUES, CALLDATA, descriptionHash);

        assert(box.getNumber() == valueToUpdate);
    }
}
