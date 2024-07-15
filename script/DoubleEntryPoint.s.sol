// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Script.sol";
import {IForta, DetectionBot} from "src/DoubleEntryPoint/DetectionBot.sol";
import {DoubleEntryPoint} from "src/DoubleEntryPoint/DoubleEntryPoint.sol";

contract DoubleEntryPointScript is Script {
    function run() public {
        vm.startBroadcast();

        DoubleEntryPoint target = DoubleEntryPoint(
            0x5e06D783fD48ce06a4829660E3E4b8E5fb969505
        );
        console.log(target.cryptoVault());
        DetectionBot bot = new DetectionBot(target.cryptoVault());
        target.forta().setDetectionBot(address(bot));

        vm.stopBroadcast();
    }
}
