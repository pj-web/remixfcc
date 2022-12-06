// Get funds from users
// Withdrow funds
// Set a minimum funding value in USD

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.8;

import "./PriceConverter.sol";

error NotOwner();

// constant, immutable

// 859,733 gas
contract FundMe {
    using PriceConverter for uint256;

    uint256 public constant MINIMUM_USD = 50 * 1e18; // 1 * 10 ** 18

    address[] public funders;
    mapping(address => uint256) public addressToAmountFunded;

    address public immutable i_owner;
    
    constructor() {
        i_owner = msg.sender;
    }

    function fund() public payable {
        // Want to set a minimum fund amount in USD
        // 1. How do we send ETH to this contract?
        require(msg.value.getConversionRate() >= MINIMUM_USD, "Didn't send enought"); // 1e18 == 1 * 10 ** 18 == 1000000000000000000
        // 18 decimals
        funders.push(msg.sender);
        addressToAmountFunded[msg.sender] += msg.value;

        // What is reverting?
        // Undo any action before, and send remaning gas back
    }


    function withdraw() public onlyOwner {
        /* starting index, ending index, step amount */
        for(uint256 funderIndex = 0; funderIndex < funders.length; funderIndex++) {
            address funder = funders[funderIndex];
            addressToAmountFunded[funder] = 0;
        }
        // We still need to reset the array
    funders = new address[](0);
    // and actually withdrow the funds

    // transfer

    // msg.sender = address
    // payable(msg.sender) = payable address 
    // payable(msg.sender).transfer(address(this).balance);

    // send
    // bool sendSuccess = payable(msg.sender).send(address(this).balance);
    // require(sendSuccess, "Send failed");

    // call
    (bool callSuccess, /* bytes memory dataReturned */) = payable(msg.sender).call{value: address(this).balance}("");
    require(callSuccess, "Call faild");
    }
    
    modifier onlyOwner {
        // require(msg.sender == i_owner, "Sender is not owner");
        if (msg.sender != i_owner) { revert NotOwner(); }
        _;
    }    
}

// What happends if someone this contract ETH without calling the fund function

receive() external payable {
    fund();
}
fallback() external payable {
    fund()
}

