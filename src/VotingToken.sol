// SPDX-License-Identifier: MIT

pragma solidity 0.8.28;

import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import {ERC20Permit} from "@openzeppelin/contracts/token/ERC20/extensions/ERC20Permit.sol";
import {ERC20Votes} from "@openzeppelin/contracts/token/ERC20/extensions/ERC20Votes.sol";
import {Nonces} from "@openzeppelin/contracts/utils/Nonces.sol";

/**
 * @title VoteToken
 * @author 0xKoiner
 * @notice Token represent the voting power of govener
 */
contract VoteToken is ERC20, ERC20Permit, ERC20Votes {
    constructor() ERC20("VoteToken", "VT") ERC20Permit("VoteToken") {}

    function _update(
        address from,
        address to,
        uint256 value
    ) internal override(ERC20, ERC20Votes) {
        super._update(from, to, value);
    }

    function nonces(
        address owner
    ) public view override(ERC20Permit, Nonces) returns (uint256) {
        return super.nonces(owner);
    }

    function mint(address _to, uint256 _amount) external {
        _mint(_to, _amount);
    }
}
