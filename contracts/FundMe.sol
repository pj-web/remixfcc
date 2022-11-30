// Get funds from users
// Withdrow funds
// Set a minimum funding value in USD

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.8;

import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

contract FundMe {

    uint256 public minimumUsd = 50 * 1e18; // 1 * 10 ** 18

    address[] public funders;
    mapping(address => uint256) public addressToAmountFunded;

    function fund() public payable {
        // Want to set a minimum fund amount in USD
        // 1. How do we send ETH to this contract?
        require(getConversionRate(msg.value) >= minimumUsd, "Didn't send enought"); // 1e18 == 1 * 10 ** 18 == 1000000000000000000
        // 18 decimals
        funders.push(msg.sender);
        addressToAmountFunded[msg.sender] = msg.value;

        // What is reverting?
        // Undo any action before, and send remaning gas back
    }

    function getPrice() public view returns (uint256) {
        // ABI
        // Address 0xD4a33860578De61DBAbDc8BFdb98FD742fA7028e
        AggregatorV3Interface priceFeed = AggregatorV3Interface(0xD4a33860578De61DBAbDc8BFdb98FD742fA7028e);
        (,int256 price,,,) = priceFeed.latestRoundData();
        // ETH in terms of USD
        // 3000.00000000
        return uint256 (price * 1e10); // 1*10 == 10000000000
    }

    function getVersion() public view returns (uint256) {
        AggregatorV3Interface priceFeed = AggregatorV3Interface(0xD4a33860578De61DBAbDc8BFdb98FD742fA7028e);
        return priceFeed.version();
    }

    function getConversionRate(uint256 ethAmount) public view returns(uint256) {
        uint256 ethPrice = getPrice();
        uint256 ethAmountInUsd = (ethPrice * ethAmount) / 1e18;
        // 2.999e21 = 2999.999999999999999999
        // 3000
        return ethAmountInUsd;
    }



    // function withdrow {}

}