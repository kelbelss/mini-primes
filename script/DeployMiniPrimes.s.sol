// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.22;

import {Script} from "forge-std/Script.sol";
import {console} from "forge-std/console.sol";
import {MiniPrimes} from "../src/MiniPrimes.sol";

contract DeployMiniPrimesScript is Script {
    function setUp() public {}

    function run() public {
        uint256 privateKey = vm.envUint("DEV_PRIVATE_KEY");
        address account = vm.addr(privateKey);

        console.log("Account", account);

        vm.startBroadcast(privateKey);
        // DEPLOY TOKEN
        MiniPrimes mini = new MiniPrimes();
        // MINT

        vm.stopBroadcast();

        console.log("Contract address: ", address(mini));
    }
}
