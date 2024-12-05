// SPDX-License-Identifier: MIT

pragma solidity 0.8.28;

import {TimelockController} from "@openzeppelin/contracts/governance/TimelockController.sol";

/**
 * @title TimeLock
 * @author 0xKoiner
 * @notice This initialize a TimelockController
 */
contract TimeLock is TimelockController {
    /** Functions */
    /** Constructor */
    /// @param _minTimeDelay Time to delay the Voting
    /// @param _proposers Addresses Arry of Proposers
    /// @param _executors Addresses Arry of Executors
    /// @dev Init TimelockController from @openzeppelin
    constructor(
        uint256 _minTimeDelay,
        address[] memory _proposers,
        address[] memory _executors
    ) TimelockController(_minTimeDelay, _proposers, _executors, msg.sender) {}
}
