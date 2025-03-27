// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test} from "forge-std/Test.sol";
import {Assignment7} from "../src/Assignment7.sol";

contract Assignment7Test is Test {
    Assignment7 assignment;
    address owner = address(this); // The test contract acts as the owner
    address recipient = address(0x123); // Test recipient

    function setUp() public {
        // pass your token name and symbol here
        assignment = new Assignment7("MyToken", "ATG");
    }

    function testMintAndTransfer() public {
        // Mint tokens to the test contract
        vm.prank(this);
        assignment.mint(address(this), 1000 * 10**18);

        // Check balance of the test contract
        uint256 balance = assignment.balanceOf(address(this));
        assertEq(balance, 1000 * 10**18, "Balance should be 1000 tokens");
        
        // Transfer some tokens
        vm.prank(this);
        assignment.transfer(recipient, 500 * 10**18);

        // Check recipient balance
        uint256 recipientBalance = assignment.balanceOf(recipient);
        assertEq(recipientBalance, 500 * 10**18, "Recipient should receive 500 tokens");

        // Ensure owner's new balance
        uint256 newOwnerBalance = assignment.balanceOf(this);
        assertEq(newOwnerBalance, 500 * 10**18, "Owner should have 500 tokens left");
    }
}
