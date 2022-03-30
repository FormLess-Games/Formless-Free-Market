// SPDX-License-Identifier: MIT
/*

  << Test Token (for use with the Test DAO) >>

*/

pragma solidity 0.8.4;

import "../lib/token/ERC20/ERC20.sol";


/**
  * @title TestToken
  * @author Project Wyvern Developers
  */
contract TestToken is ERC20("test", "TST") {

    /**
     */
    constructor () public {
      _mint(msg.sender, 1000000000000000);
    }

    /**
     */
    function mint(address to, uint256 value) public returns (bool) {
        _mint(to, value);
        return true;
    }

    function decimals() public view virtual override returns (uint8) {
        return 6;
    }

}

