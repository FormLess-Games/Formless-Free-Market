// SPDX-License-Identifier: MIT
/*

  << Wyvern Static >>

*/

pragma solidity 0.8.4;

import "./static/StaticERC20.sol";
import "./static/StaticERC721.sol";
import "./static/StaticERC1155.sol";
import "./static/StaticUtil.sol";

/**
 * @title WyvernStatic
 */
contract WyvernStatic is StaticERC20, StaticERC721, StaticERC1155, StaticUtil {

    string public constant name = "Wyvern Static";

    constructor (address atomicizerAddress) {
        atomicizer = atomicizerAddress;
    }

    function test () 
        public
        pure
    {
    }

}
