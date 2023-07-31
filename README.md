# PaymentContract Smart Contract

This is a simple Ethereum smart contract for handling payments, deposits, and withdrawals.

## Introduction

The `PaymentContract` is designed to manage funds by allowing users to deposit Ether into the contract and the contract owner to withdraw funds when needed.

## Features

- **Secure Transaction Handling:** The contract uses `require()`, `assert()`, and `revert()` statements to ensure secure transaction handling and validate user inputs.

- **Deposit Function with Validation:** The `deposit` function allows users to deposit Ether into the contract. It uses `require()` to check if the deposit value is greater than zero, ensuring valid deposit amounts.

- **Internal Consistency Check:** The `deposit` function also uses `assert()` to verify the internal consistency of the contract by comparing the contract's balance to the `totalBalance`.

- **Withdraw Function with Validation:** The `withdraw` function allows the contract owner to withdraw funds. It uses `require()` to check if the contract has enough balance for withdrawal and prevents overdrawing.

- **Custom Conditions Handling:** The `withdraw` function further uses `revert()` to handle custom conditions. If the sender is not the contract owner, the transaction reverts, ensuring that only the owner can withdraw funds.

## Getting Started

To interact with the `PaymentContract` on Remix, follow the instructions below.

### Prerequisites

- [Remix IDE](https://remix.ethereum.org/): Remix is an Ethereum IDE that allows you to write, compile, and deploy smart contracts.

### Deployment

1. Open the Remix IDE in your browser.

2. Create a new file and name it `PaymentContract.sol`.

3. Paste the following smart contract code into `PaymentContract.sol`:

```solidity
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
```

Compile the PaymentContract by selecting the Solidity compiler version and clicking on the "Compile" button in Remix.

Deploy the PaymentContract to the Ethereum network of your choice. You can use the Remix's "Deploy & Run Transactions" tab to deploy the contract using one of the deployment environments (e.g., JavaScript VM, Injected Web3).
