// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract PaymentContract {
    address public owner;
    uint256 public totalBalance;

    constructor() {
        owner = msg.sender;
    }

    function deposit() external payable {
        // Use require to check if the deposit value is greater than zero.
        require(msg.value > 0, "Deposit amount should be greater than zero.");

        // Use assert to check for internal consistency.
        assert(address(this).balance >= totalBalance);

        totalBalance += msg.value;
    }

    function withdraw(uint256 amount) external {
        // Use require to check if the contract has enough balance for withdrawal.
        require(amount <= totalBalance, "Insufficient balance.");

        // Use revert to handle custom conditions.
        if (msg.sender != owner) {
            revert("Only the contract owner can withdraw.");
        }

        totalBalance -= amount;
        payable(msg.sender).transfer(amount);
    }
}

