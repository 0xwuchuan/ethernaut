// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Script.sol";
import {IForta, AlertBot} from "src/DoubleEntryPoint/AlertBot.sol";

interface IDoubleEntryPoint {
    function forta() external view returns (IForta);
    function cryptoVault() external view returns (address);
}

contract DoubleEntryPointScript is Script {
    function run() public {
        vm.startBroadcast();

        IDoubleEntryPoint target = IDoubleEntryPoint(0x5e06D783fD48ce06a4829660E3E4b8E5fb969505);
        console.log(target.cryptoVault());
        AlertBot alertBot = new AlertBot(target.cryptoVault());
        target.forta().setDetectionBot(address(alertBot));

        vm.stopBroadcast();
    }
}
