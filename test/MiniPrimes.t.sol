// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.22;

import "forge-std/Test.sol";

import {MiniPrimes} from "../src/MiniPrimes.sol";
import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";

contract MiniPrimesTest is Test {
    uint256 public constant NFT_PRICE = 1 ether; //1e18

    // Events
    event BuyPrime(address indexed _to, uint256 indexed tokenId);
    event DisputePrime(address indexed disputer, address indexed owner, uint256 indexed tokenId);

    // Variables
    MiniPrimes mini;

    // Addresses
    address OWNER = makeAddr("Owner");
    address MINTER = makeAddr("Minter");
    address DISPUTER = makeAddr("Disputer");

    function testSeeAddress() public view {
        console.log("Addresses are", MINTER, OWNER, DISPUTER);
    }

    function setUp() public {
        vm.prank(OWNER);
        mini = new MiniPrimes();

        // give MINTER 100 ETH
        deal(MINTER, 100e18);
    }

    // BUY FUNCTION TESTS

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

    function test_buy_fail_InsufficientFunds() public {
        vm.startPrank(MINTER);
        vm.expectRevert(MiniPrimes.InsufficientFunds.selector);
        mini.buy{value: 0}(MINTER, 2);
    }

    function test_buy_success() public {
        // check balance to ensure checks happen and state is as it should be
        assertEq(mini.balanceOf(MINTER), 0);

        vm.prank(MINTER);
        mini.buy{value: NFT_PRICE}(MINTER, 1);

        assertEq(mini.balanceOf(MINTER), 1);
    }

    function test_buy_event() public {
        // tell Foundry which data to check - index 1, index 2, index 3, check data
        vm.expectEmit(true, true, false, true);

        // emit expected
        emit BuyPrime(address(MINTER), 10);

        // Call function that should emit
        mini.buy{value: NFT_PRICE}(address(MINTER), 10);
    }

    // DISPUTE FUNCTION TESTS

    function test_dispute_fail_InvalidFactor() public {
        vm.expectRevert(MiniPrimes.InvalidFactor.selector);
        mini.dispute(10, 10);

        vm.expectRevert(MiniPrimes.InvalidFactor.selector);
        mini.dispute(10, 1);
    }

    function test_dispute_fail_NotFactor() public {
        vm.expectRevert(MiniPrimes.NotFactor.selector);
        mini.dispute(10, 3);
    }

    function test_dispute_success() public {
        vm.prank(MINTER);
        mini.buy{value: NFT_PRICE}(MINTER, 10);
        assertEq(mini.balanceOf(MINTER), 1);
        assertEq(mini.ownerOf(10), MINTER);
        mini.dispute(10, 2);
        assertEq(mini.balanceOf(MINTER), 0);
    }

    function test_dispute_event() public {
        vm.prank(MINTER);
        mini.buy{value: NFT_PRICE}(MINTER, 10);

        // prank disputer
        vm.startPrank(DISPUTER);
        vm.expectEmit(true, true, true, true);

        // emit expected
        emit DisputePrime(DISPUTER, MINTER, 10);

        // Call function that should emit
        mini.dispute(10, 2);
    }

    // WITHDRAW FUNCTION TESTS

    function test_withdrawETH() public {
        vm.prank(MINTER);
        mini.buy{value: NFT_PRICE}(MINTER, 10);

        vm.prank(OWNER);
        mini.withdrawETH(OWNER);
    }

    function test_withdrawETH_fail_NotOwner() public {
        vm.prank(MINTER);
        mini.buy{value: NFT_PRICE}(MINTER, 10);

        // Custom error with parameter
        bytes memory errorData = abi.encodeWithSelector(Ownable.OwnableUnauthorizedAccount.selector, DISPUTER);

        vm.prank(DISPUTER);
        vm.expectRevert(errorData);
        mini.withdrawETH(DISPUTER);
    }
}
