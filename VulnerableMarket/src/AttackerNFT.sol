// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.15;

import "@openzeppelin-contracts/token/ERC721/ERC721.sol";
import "@openzeppelin-contracts/access/Ownable.sol";


contract AttackerNFT is ERC721, Ownable{

       constructor() ERC721("AttackerNFT", "ANFT") {
    }
    function mint(address recipient, uint256 tokenId) public onlyOwner {        
        _mint(recipient, tokenId);
    }


}