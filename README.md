
# Summary
Smart contract for equity tokens (share tokens).
 # Abstract
A smart contract of a joint-stock company with the possibility of decentralized management of the company is presented. With the possibility of voting, paying dividends, accepting and excluding members of the Board of Directors. Compatible with ERC 20. Token holders are divided into two categories: token holders with the ability to receive dividends and company owners. Both categories receive dividends. The difference is that token holders do not participate in the management of the company due to non-significant investments, and company owners have the right to manage the company due to large investments in the company. The number of members of the Board of Directors is unlimited.
# Specification
## FAS
The Etherium smart contract is an extension of the ERC 20 standard. The smart contract is designed to indicate the principle of fairness. Implementation with the help of blockchain technology allows capital tokens to work in strict mode, perform any process transparently using pre-created software code. The agreement standard allows you to request information about the project and the share capital. Decentralized management of the company, distribution of profits, tracking the progress of the project and its results.
Methods
## The contract is divided into four chapters:
 I.	Chapter. The ERC20 standard and related functions.
	
 II.	Chapter. Inclusion and exclusion of members of the Board of Directors.
	
 III.	Chapter. The ballot, the conclusion of the voting results, the query on the database the results of past votes.
	
 IV.	Chapter. The payment of dividends.





### Chapter I.	
### The ERC20 standard is filled with standard functions for transferring tokens from one holder to another.
``` solidity
function balanceOf(address tokenOwner) public view returns (uint256 amount); 
```
``` solidity
function allowance(address tokenOwner, address spender) public view returns (uint remaining);
``` 
``` solidity
function transfer(address recipient, uint256 amount) public returns (bool); 
``` 
The function added a global (mapping) variable with a time stamp for the transition from one token holder to another. This data is necessary to ensure security from receiving multiple dividends. During the period of dividend payment, it is prohibited to receive a dividend when the token balance increases. This is provided for the following: You have two or more addresses in the asset, during the dividend payment period you received a reward at one address, then transferred the tokens to your second address and received the dividends again, and so you can do an infinite number of times by moving the tokens to your existing addresses. Therefore, it will not be possible to increase the token balance and get dividends. 
``` solidity
function approve(address spender, uint256 amount) public returns (bool);
```
``` solidity
function transferFrom(address sender, address recipient, uint256 amount) public returns (bool); 
```
The function added a global (mapping) variable with a time stamp for the transition from one token holder to another. This data is necessary to ensure security from receiving multiple dividends. During the period of dividend payment, it is prohibited to receive a dividend when the token balance increases. This is provided for the following: You have two or more addresses in the asset, during the dividend payment period you received a reward at one address, then transferred the tokens to your second address and received the dividends again, and so you can do an infinite number of times by moving the tokens to your existing addresses. Therefore, it will not be possible to increase the token balance and get dividends.
``` solidity
event Transfer(address indexed _from, address indexed to, uint256 tokens);
event Approval(address indexed tokenOwner, address indexed spender, uint256 tokens);
``` 
### Chapter II.	
### Inclusion and exclusion of members of the Board of Directors.
**projectOwner**
``` solidity
function projectOwner() external view returns (address) 
return project_owner;
```
**acceptOwnership**
``` solidity
function acceptOwnership() external 
```
Only a newly invited member of the Board of Directors can call the function. A new member of the Board of Directors has 24 hours to make a decision. After this period, the offer is automatically canceled. After making a positive decision, the address will be displayed in the getOwnersList () function.

**checkOwner**
```solidity
function checkOwner (address address_owner) public view returns (bool)
```
Check your address for membership in the Board of Directors.
Return bool

**delOwner**
```solidity
function delOwner (address address_owner) public
```
Removes a member from the Board of Directors. To confirm the right to remove a participant from the Board of Directors, the contract owner must provide a voting record with a positive decision, otherwise the participant must be reinstated immediately.

**getOwnersList**
```solidity
function getOwnersList() public view returns (address[] memory Owners_List)
```
Displays addresses of company owners
Return address[]memory

**getNumOfOwners**
```solidity
function getNumOfOwners() public view returns (uint256 number)
```
Returns the number of members of the Board of Directors.
Return uint256

**newOwnerInvite**
```solidity
function newOwnerInvite(address _new_owner) public
```
Only the project owner can invite a new member of the Board of Directors. This function starts a timer for a new Board member to make a decision. You can invite an unlimited number of Board Members in order of priority.

### Chapter III.	
### Vote.

**createVote**
```solidity
function createVote() public returns (uint256)
```
Only the project owner can call the function. Calling the function sets the start and end time of voting, assigns the voting number, and resets the previous voting data. The voting lasts 24 hours.
Return uint256

**vote**
```solidity
function vote(uint256 _vote_status_value) public
```
Only a member of the Board of Directors can participate in the voting. Votes are counted using a weighted method that depends on the number of tokens the company owner has. Non-voting members of the Board of Directors are classified as abstainers. When the company owner has made a choice in favor of a question or against it, a timestamp is attached to the completed action, which prohibits re-voting on the current question. The choice made by a member of the Board of Directors is secret, it is impossible to track the choice within the smart contract!

**currentVoting**
```solidity
function currentVoting () public view returns (uint256 _votes_num, uint256 _quorum, uint256 _start_vote, uint256 _end_vote);
```
Shows the current vote: the voting number, the number of tokens that have already voted, the start time, and the end time of the vote.
Return uint256, uint256, uint256, uint256

**getVoteResult**
```solidity
function getVoteResult() public returns (uint256 [] memory)
```
The function can only be called after the end of the voting time. Returns the results of the completed vote: the voting number, the voting result, the quorum, the start time of voting, and the end time of voting.
Return uint256[]memory

**previousVoteResult**
```solidity
function previousVoteResult() public view returns (uint256 vote_ID, uint256 Result, uint256 Quorum, uint256 Start, uint256 End)
```
Shows the result of the last vote is valid until the end of the current one.
Return uint256, uint256, uint256, uint256, uint256

**getVotingDataBase**
```solidity
function getVotingDataBase (uint256 _voting_num) public
```
Get access to the database of votes held by the voting number to resolve possible disputes in the process of managing the company, as well as for newly accepted members of the Board of Directors, the ability to track all the votes held.

**showVotingDataBase**
```solidity
function showVotingDataBase () public view returns (uint256 vote_ID, uint256 Result, uint256 Quorum, uint256 Start, uint256 End)
```
Publishes the result of calling the previous function. The reason is that EVM cannot generate an array of global variables and display them as an array in a single function. To reset the published voting database, you must use the getVotingDataBase() function to request information by the number "0".
Return uint256, uint256, uint256, uint256, uint256

### Chapter IV.	
### Payment of dividends.

**dividendPaymentsTime**
```solidity
function dividendPaymentsTime (uint256 _start) public onlyOwner returns (uint256 Start_reward, uint256 End_reward)
```
Only project owner has access to the function call. The function call confirms the start time and end time of the dividend payment period. The announcement of the start of payment of dividends must be no later than one month before the start. The dividend payment period is 30 days. The function call approves the dividend payment Fund depending on the amount of Ether on the contract balance.
Return uint256, uint256

**treasuryRest**
```solidity
function treasuryRest () public view returns (uint256)
```
Returns the current balance of the dividend payment Fund.
Return uint256

**reward**
```solidity
function reward (address token_holder) public view returns (uint256 Reward)
```
The function can only be called after the approval of the dividend payment Fund. Otherwise, the contract balance is zero. Each token holder can check their reward in wei. The minimum number of tokens to receive dividends is 0.001%, so your reward will be calculated based on this number of tokens from the total amount of the dividend payment Fund.
Return uint256

**withdrawDividend**
```solidity
function withdrawDividend() external
```
Only the token owner with at least 0.001% of tokens can call the function (the contract cannot count fewer toxins). The remuneration payable to You is deducted from the balance of the contract. It is forbidden to increase the balance of tokens on the address during the dividend payment period to prevent re-receipt of dividends. All token transfers can be performed after receiving dividends..

**depositEther**
```solidity
function depositEther() external payable
```
Only the contract owner can make a deposit to the contract balance.

**accept ETH**
```solidity
function() external payable
```
## Compatibility

The shareholder agreement standard is compatible with ERC-20.
