## Mini Primes

**ERC721 NFT contract with Foundry tests and a deploy script.**

This NFT smart contract project allows users to mint unique NFTs associated with prime numbers. Here's how it works:

- **Minting**: Users can mint an NFT associated with a specific number by paying 1 ETH. The number they choose must be available and ideally a prime number.
- **Verification**: Once a user has minted an NFT, other users can dispute whether the chosen number is indeed a prime number or not.
- **Dispute Resolution**: If a number is disputed, the smart contract will verify whether it's a prime number or not. If it's found to be prime, the NFT remains with the original owner. If not, the NFT will be burnt.

This mechanism encourages users to choose prime numbers for their NFTs and ensures the accuracy of the associated mathematical properties. It adds an interactive and community-driven aspect to the NFT minting process.

| File               | % Lines         | % Statements   | % Branches    | % Funcs       |
| ------------------ | --------------- | -------------- | ------------- | ------------- |
| src/MiniPrimes.sol | 100.00% (12/12) | 95.83% (23/24) | 90.00% (9/10) | 100.00% (3/3) |
| Total              | 63.16% (12/19)  | 67.65% (23/34) | 90.00% (9/10) | 60.00% (3/5)  |

| File               | % Lines                                          | % Statements                                     | % Branches                                     | % Funcs                                        |
| ------------------ | ------------------------------------------------ | ------------------------------------------------ | ---------------------------------------------- | ---------------------------------------------- |
| src/MiniPrimes.sol | <span style="color:green">100.00% (12/12)</span> | <span style="color:green">95.83% (23/24)</span>  | <span style="color:green">90.00% (9/10)</span> | <span style="color:green">100.00% (3/3)</span> |
| Total              | <span style="color:orange">63.16% (12/19)</span> | <span style="color:orange">67.65% (23/34)</span> | <span style="color:green">90.00% (9/10)</span> | <span style="color:orange">60.00% (3/5)</span> |
