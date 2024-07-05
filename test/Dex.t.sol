// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {AttackDex} from "src/Dex/AttackDex.sol";
import {Dex, IERC20} from "src/Dex/Dex.sol";

contract DexTest is Test {
    Dex target;
    AttackDex attack;

    function setUp() public {
        target = Dex(0x2788040F6086aF8e663E7eCEa1D620d03c28d8Bb);
        attack = new AttackDex(address(target));
        IERC20 token1 = IERC20(target.token1());
        IERC20 token2 = IERC20(target.token2());
        vm.startBroadcast(0x777dcCD91f7C62717DBa44db3504bDf47C75E2F1);
        token1.approve(address(attack), type(uint256).max);
        token2.approve(address(attack), type(uint256).max);
    }

    function testAttack() public {
        attack.attack();
    }
}
