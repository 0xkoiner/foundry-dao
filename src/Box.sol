// SPDX-License-Identifier: MIT

pragma solidity 0.8.28;

import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";

/**
 * @title Box
 * @author 0xKoiner
 * @notice This contract present the DAO changings
 */
contract Box is Ownable {
    /** States */
    uint256 private s_number;

    /** Events */
    event NumberWasChanged(uint256 indexed _number);

    /** Functions */
    /** Constructor */
    /// @dev Init Owner to Ownable contract of @openzeppelin
    constructor() Ownable(msg.sender) {}

    /** Setters */
    /// @param _newNumber Pass a new number to set in s_number
    /// @dev Only Owner can set
    function store(uint256 _newNumber) public onlyOwner {
        s_number = _newNumber;
        emit NumberWasChanged(_newNumber);
    }

    /** Getters */
    /// @return s_number Return a value of s_number
    function getNumber() external view returns (uint256) {
        return s_number;
    }
}
