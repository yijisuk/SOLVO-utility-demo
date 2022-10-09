// SPDX-License-Identifier: Unlicense

pragma solidity ^0.8.4;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract GenerateVerification is ERC721URIStorage, Ownable {

    uint256 public tokenCounter;
    uint256 public maxSupply;

    mapping(uint256 => Attr) public attributes;

    struct Attr {
        string title;
        string description;
        string date;
    }

    constructor() public ERC721("Verification", "VRF") {
        tokenCounter = 0;
        maxSupply = 5;
    }

    function setMaxSupply(uint256 maxSupply_) external onlyOwner {
        maxSupply = maxSupply_;
    }

    function generateVerification(string memory title_, string memory description_, string memory date_) public returns (uint256) {
        require(maxSupply > tokenCounter, "all tokens are minted");

        uint256 newItemId = tokenCounter;
        _safeMint(msg.sender, newItemId);
        attributes[newItemId] = Attr(title_, description_, date_);
        tokenCounter = tokenCounter + 1;
        return newItemId;
    }

}