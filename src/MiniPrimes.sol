// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.22;

import {ERC721} from "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract MiniPrimes is ERC721 {
    error AlreadyMinted();
    error InsufficientFunds();

    uint256 public constant NFT_PRICE = 1 ether; //1e18

    constructor() ERC721("MiniPrimes", "PRIME") {}

    function buy(address _to, uint256 tokenId) external payable {
        // revert if already minted
        if (_ownerOf(tokenId) != address(0)) revert AlreadyMinted();

        // charge 1 eth
        if (msg.value < NFT_PRICE) revert InsufficientFunds();

        // tokenID == NFT number wanted
        _mint(_to, tokenId);
    }

    // function dispute() {}
}
