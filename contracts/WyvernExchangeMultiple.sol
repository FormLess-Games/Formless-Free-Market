// SPDX-License-Identifier: MIT
/*

  << Wyvern Exchange >>

*/

pragma solidity 0.8.4;

import "./exchange/Exchange.sol";

/**
 * @title WyvernExchange
 * @author Wyvern Protocol Developers
 */
contract WyvernExchange is Exchange {

    string public constant name = "Wyvern Exchange Multiple";
  
    string public constant version = "4.1";

    string public constant codename = "Ancalagon";

    /**
     * @dev Initialize a WyvernExchange instance
     * @param registryAddress Address of the registry instance which this Exchange instance will use
     * @param tokenAddress Address of the token used for protocol fees
     */
    constructor (ProxyRegistry registryAddress, TokenTransferProxy tokenTransferProxyAddress, ERC20 tokenAddress, address protocolFeeAddress) Ownable() {
        registry = registryAddress;
        tokenTransferProxy = tokenTransferProxyAddress;
        exchangeToken = tokenAddress;
        protocolFeeRecipient = protocolFeeAddress;
    }

    function atomicMatchMultiple(
        address[] memory addrs,
        uint[] memory uints,
        uint8[] memory feeMethodsSidesKindsHowToCalls,
        bytes[] memory callDataBuy,
        bytes[] memory callDataSell,
        bytes[] memory replacementPatternBuy,
        bytes[] memory replacementPatternSell,
        bytes[] memory staticExtradataBuy,
        bytes[] memory staticExtradataSell,
        uint8[] memory vs,
        bytes32[] memory rssMetadata
    ) public payable {
        require(addrs.length % 14 == 0, "Address Invalid");
        require(uints.length % 18 == 0, "Uints Invalid");
        require(feeMethodsSidesKindsHowToCalls.length % 8 == 0, "feeMethodsSidesKindsHowToCalls Invalid");
        require(vs.length % 2 == 0, "Vs Invalid");
        require(rssMetadata.length % 5 == 0, "rssMetadata Invalid");

        uint256 length = callDataBuy.length;

        require(callDataSell.length == length, "callDataSell Invalid");
        require(replacementPatternBuy.length == length, "replacementPatternBuy Invalid");
        require(replacementPatternSell.length == length, "replacementPatternSell Invalid");
        require(staticExtradataBuy.length == length, "staticExtradataBuy Invalid");
        require(staticExtradataSell.length == length, "staticExtradataSell Invalid");

        for (uint256 i = 0; i < callDataBuy.length; i++) {
            uint256 addrsIndex = i * 14;
            uint256 uintsIndex = i * 18;
            uint256 callsIndex = i * 8;
            uint256 vsIndex = i * 2;
            uint256 rssMetadataIndex = i * 5;

            address[14] memory newAddrs;
            uint[18] memory newUints;
            uint8[8] memory newCalls;
            uint8[2] memory newVs;
            bytes32[5] memory newRessMetadata;

            for (uint256 j = 0; j < 14; j++) newAddrs[j] = addrs[j + addrsIndex];
            for (uint256 j = 0; j < 18; j++) newUints[j] = uints[j + uintsIndex];
            for (uint256 j = 0; j < 14; j++) newCalls[j] = feeMethodsSidesKindsHowToCalls[j + callsIndex];
            for (uint256 j = 0; j < 14; j++) newVs[j] = vs[j + vsIndex];
            for (uint256 j = 0; j < 14; j++) newRessMetadata[j] = rssMetadata[j + rssMetadataIndex];

            atomicMatch_(
                newAddrs, newUints, newCalls, callDataBuy[i], callDataSell[i], replacementPatternBuy[i],
                replacementPatternSell[i], staticExtradataBuy[i], staticExtradataSell[i], newVs, newRessMetadata
            );
        }
    }
}
