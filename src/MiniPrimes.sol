// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.22;

import {ERC721} from "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract MiniPrimes is ERC721 {
    constructor() ERC721("MiniPrimes", "PRIME") {}
    // function buy() {}
    // function dispute() {}
}
