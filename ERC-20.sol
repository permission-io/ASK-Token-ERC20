// SPDX-License-Identifier: MIT
pragma solidity ^0.8.2;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import "@openzeppelin/contracts/access/AccessControl.sol";

contract MyToken is ERC20, ERC20Burnable, AccessControl {
    bytes32 public constant MINTER_ROLE = keccak256("MINTER_ROLE");
    
    uint256 private constant _maxSupply = 1e29;


    constructor() ERC20("Permission Token", "ASK") {
        _grantRole(DEFAULT_ADMIN_ROLE, msg.sender);
    }

    function getMaxSupply()  public pure returns  (uint256) {
         return _maxSupply;
     }


    function mint(address to, uint256 amount) public onlyRole(MINTER_ROLE) {
        require(totalSupply() + amount <= _maxSupply, "Max Supply Exceeded");
        _mint(to, amount);
    }
}
