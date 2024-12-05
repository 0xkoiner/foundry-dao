# DAO Founders Project  

A fully decentralized governance protocol enabling collective decision-making through voting. This project includes contracts for managing governance, voting tokens, and time-locking execution, ensuring a secure and democratic process. Built with Solidity and rigorously tested to verify its mechanisms and robustness.  

## Smart Contracts  

- **Box.sol**: The target contract, acting as the functional implementation for DAO proposals.  
- **TimeLock.sol**: Implements a time-lock mechanism to enforce a delay period between successful proposals and their execution, ensuring transparency and protection against rushed decisions.  
- **TokenDao.sol**: The DAO contract managing governance proposals, votes, and the overall decision-making process.  
- **VotingToken.sol**: Provides voting power to participants in proportion to their token holdings, integrating seamlessly with the governance mechanism.  

## Features  

- **Decentralized Governance**: Token holders can propose, vote, and execute decisions collectively.  
- **Time-Lock Mechanism**: Adds a delay after successful voting before executing proposals, safeguarding against sudden changes.  
- **Voting Power via Tokens**: VotingToken.sol ensures a fair distribution of voting power based on token holdings.  
- **Proposal Lifecycle**: Submit, vote, and execute proposals in a fully transparent workflow.  

## Testing  

This project includes extensive testing to ensure the DAO functions as intended:  

- **Proposal Creation and Execution**: Verified that proposals are created, voted on, and executed as per the governance rules.  
- **Voting Mechanism**: Tested voting power allocation, vote tallying, and the conditions for proposal approval.  
- **Time-Lock Functionality**: Ensured that TimeLock.sol delays execution until the specified time has elapsed.  
- **Edge Cases and Security**: Covered scenarios such as multiple proposals, conflicting votes, and token transfers during active voting periods.  
- **Comprehensive Contract Testing**: Used Foundry to rigorously test all contracts for functionality and robustness under various conditions, including edge cases.  

## How It Works  

1. **Token Distribution**: VotingToken.sol distributes tokens to DAO members, representing their voting power.  
2. **Proposal Creation**: DAO members can submit proposals through TokenDao.sol.  
3. **Voting**: Members vote on proposals, with their influence determined by their token holdings.  
4. **Time Lock**: Once a proposal passes, TimeLock.sol enforces a delay before execution.  
5. **Execution**: After the time lock, proposals are executed via Box.sol, the target contract.  

## Ideal For  

This project is perfect for learning about DAOs, Solidity-based governance mechanisms, and time-lock implementations. Whether you’re exploring decentralized decision-making or building your own DAO, this project provides a complete and tested foundation.  

---

