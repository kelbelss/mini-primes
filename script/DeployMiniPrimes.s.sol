// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.22;

import {Script, console} from "forge-std/Script.sol";
import {MiniPrimes} from "../src/MiniPrimes.sol";

contract MiniPrimesScript is Script {
    function setUp() public {}

    function run() public {
        vm.broadcast();
    }
}
