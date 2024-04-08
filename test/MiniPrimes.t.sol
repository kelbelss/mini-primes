// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.22;

import "forge-std/Test.sol";

import {MiniPrimes} from "../src/MiniPrimes.sol";

contract MiniPrimesTest is Test {
    // Variables
    MiniPrimes mini;

    // Addresses
    address OWNER = makeAddr("Owner");
    address MINTER = makeAddr("Minter");

    function testSeeAddress() public view {
        console.log("Addresses are", MINTER, OWNER);
    }

    function setUp() public {
        vm.prank(OWNER);
        mini = new MiniPrimes();

        // give MINTER 100 ETH
        deal(MINTER, 1e18);
    }

    function testBuyID() public view {}

    function testPayment() public view {}

    function testSuccessfulBuy() public view {}
}
