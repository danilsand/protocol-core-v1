// SPDX-License-Identifier: BUSDL-1.1
pragma solidity 0.8.26;

import { ERC1155 } from "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import { Ownable } from "@openzeppelin/contracts/access/Ownable.sol";

contract MockERC1155 is ERC1155, Ownable {
    // Events to track token issuance and token burning
    event Mint(address indexed to, uint256 indexed tokenId, uint256 value);
    event Burn(address indexed from, uint256 indexed tokenId, uint256 value);

    constructor(string memory uri) ERC1155(uri) {}

    // Function for issuing tokens
    function mintId(address to, uint256 tokenId, uint256 value) public onlyOwner returns (uint256) {
        require(to != address(0), "MockERC1155: mint to the zero address");
        require(value > 0, "MockERC1155: mint value must be greater than zero");

        _mint(to, tokenId, value, "");
        emit Mint(to, tokenId, value);
        return tokenId;
    }

    // Function for burning tokens
    function burn(address from, uint256 tokenId, uint256 value) public onlyOwner {
        require(from != address(0), "MockERC1155: burn from the zero address");
        require(value > 0, "MockERC1155: burn value must be greater than zero");

        _burn(from, tokenId, value);
        emit Burn(from, tokenId, value);
    }
}
