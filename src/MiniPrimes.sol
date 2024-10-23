// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.22;

import {ERC721} from "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";

contract MiniPrimes is ERC721, Ownable {
    error FailedToSend();
    error AlreadyMinted();
    error InsufficientFunds();
    error InvalidFactor();
    error NotFactor();

    event BuyPrime(address indexed _to, uint256 indexed tokenId);
    event DisputePrime(
        address indexed disputer,
        address indexed owner,
        uint256 indexed tokenId
    );

    uint256 public constant NFT_PRICE = 1 ether; //1e18

    constructor() ERC721("Mini Primes", "PRIME") Ownable(msg.sender) {}

    function withdrawETH(address _to) external payable onlyOwner {
        uint256 balance = address(this).balance;
        (bool sent, ) = payable(_to).call{value: balance}("");
        if (!sent) revert FailedToSend();
    }

    function buy(address _to, uint256 tokenId) external payable {
        // revert if already minted
        if (_ownerOf(tokenId) != address(0)) revert AlreadyMinted();

        // charge 1 eth
        if (msg.value < NFT_PRICE) revert InsufficientFunds();

        // tokenID == NFT number wanted
        _mint(_to, tokenId);

        emit BuyPrime(_to, tokenId);
    }

    function dispute(uint256 mintedTokenId, uint256 factor) external {
        // check that the factor supplied is not 1 or the NFT ID number itself
        if (factor == 1 || factor == mintedTokenId) revert InvalidFactor();

        // check that the factor does divide the NFT ID evenly
        if (mintedTokenId % factor != 0) revert NotFactor();

        address _owner = _ownerOf(mintedTokenId);

        // If it does not, revert. If it does, burn the NFT
        _burn(mintedTokenId);

        emit DisputePrime(msg.sender, _owner, mintedTokenId);
    }
}

// TODO

// 1. Add incentive for Disputer - currently the NFT burns, what does Disputer get?
// 2. Adjust price for NFT.
// 3. Figure out which frontend system is best and make a basic one.
// 4. Design and code the NFT card.
