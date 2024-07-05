// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Script.sol";
import {AttackWallet} from "src/PuzzleWallet/AttackWallet.sol";

contract PuzzleWalletScript is Script {
    function run() external {
        vm.startBroadcast(0x777dcCD91f7C62717DBa44db3504bDf47C75E2F1);

        new AttackWallet{value: 0.001 ether}(0x94Af6eD75191F384F036435eC58478E4566e6902);

        vm.stopBroadcast();
    }
}
