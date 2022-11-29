// Get funds from users
// Withdrow funds
// Set a minimum funding value in USD

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.8;

contract FundMe {

    uint256 public minimumUsd = 50;

    function fund() public payable {
        // Want to set a minimum fund amount in USD
        // 1. How do we send ETH to this contract?
        require(msg.value >= minimumUsd, "Didn't send enought"); // 1e18 == 1 * 10 ** 18 == 1000000000000000000

        // What is reverting?
        // Undo any action before, and send remaning gas back
    }

    function getPrice() public {
        // ABI
        // Address 0xD4a33860578De61DBAbDc8BFdb98FD742fA7028e
    }

    function getVersion() public view returns (uint256) {
        AggregatorV3Interface priceFeed = AggregatorV3Interface(0xD4a33860578De61DBAbDc8BFdb98FD742fA7028e);
        return priceFeed.version();
    }

    function getConversionRate() public {}



    // function withdrow {}

}