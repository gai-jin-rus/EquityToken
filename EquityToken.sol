pragma solidity ^0.5.16;

import "./ERC20_EquityToken.sol";

contract VERTO is ERC25BasicContract {
    using SafeMath for uint256;

constructor () public{
	totalSupply = 100000000000000000000000; 
	name = "Public Company";
		decimals = 18;
		symbol = "PCT";
		version = "1.0";
	   balances[msg.sender] = totalSupply; 
	}
}
