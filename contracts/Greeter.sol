pragma solidity ^0.8.0;

import "hardhat/console.sol";

contract MyStreamContract {
    uint totalBros;
	uint256 private seed;

	event NewBro(address indexed from, uint256 timestamp, string message);

	struct Bro {
		address waver;
		string message;
		uint256 timestamp;
	}

	Bro[] bros;

	mapping(address => uint256) public lastBroed;

	constructor() payable {
        console.log("Satyam");

		seed = (block.timestamp + block.difficulty) % 100;
    }

	function bro(string memory _message) public {
		
		require(
			lastBroed[msg.sender] + 30 seconds < block.timestamp,
			"Wait 15m"
		);
		
		lastBroed[msg.sender] = block.timestamp;

		console.log(lastBroed[msg.sender]);

		totalBros += 1;
		console.log("Bro'ed you!!");

		bros.push(Bro(msg.sender, _message, block.timestamp));

		seed = (block.timestamp + block.difficulty + seed) % 100;

		if(seed <= 50) {
			uint256 prizeAmount = 0.0001 ether;
			require(
				prizeAmount <= address(this).balance,
				"Trying to withdraw more money than the contract has."
			);
			(bool success, ) = (msg.sender).call{value: prizeAmount}("");
			require(success, "Failed to withdraw money from contract.");
		}

		emit NewBro(msg.sender, block.timestamp, _message);
	}

	function getAllBros() public view returns (Bro[] memory) {
		return bros;
	}

	function getTotalBros() public view returns (uint) {
		return totalBros;
	}
}