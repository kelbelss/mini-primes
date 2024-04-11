// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.22;

import "forge-std/Test.sol";

import {MiniPrimes} from "../src/MiniPrimes.sol";

contract MiniPrimesTest is Test {
    uint256 public constant NFT_PRICE = 1 ether; //1e18

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
        deal(MINTER, 100e18);
    }

    function test_buy_fail_tokenIdAlreadyMinted() public {
        // check balance to ensure checks happen and state is as it should be
        assertEq(mini.balanceOf(MINTER), 0);

        // Mint a token
        vm.startPrank(MINTER);
        mini.buy{value: NFT_PRICE}(MINTER, 1);

        assertEq(mini.balanceOf(MINTER), 1);

        // Try mint same Id
        vm.expectRevert(MiniPrimes.AlreadyMinted.selector);
        mini.buy{value: NFT_PRICE}(MINTER, 1);

        assertEq(mini.balanceOf(MINTER), 1);

        // Stop MINTER prank
        vm.stopPrank();
    }

    function test_buy_fail_InsufficientFunds() public view {}

    function test_buy_success() public view {}
}
