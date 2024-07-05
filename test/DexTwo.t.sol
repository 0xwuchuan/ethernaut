// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {AttackDexTwo} from "src/DexTwo/AttackDexTwo.sol";
import {DexTwo, IERC20} from "src/DexTwo/DexTwo.sol";

contract DexTest is Test {
    DexTwo target;
    AttackDexTwo attack;

    function setUp() public {
        vm.startBroadcast(0x777dcCD91f7C62717DBa44db3504bDf47C75E2F1);

        target = DexTwo(0xDa47424d14AeA05128F980E6528D036d12eEF739);
        attack = new AttackDexTwo(address(target));

        vm.stopBroadcast();
    }

    function testAttack() public {
        attack.attack();
    }
}
