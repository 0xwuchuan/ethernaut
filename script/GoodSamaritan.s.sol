// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Script.sol";
import {IGoodSamaritan, BadSamaritan} from "src/GoodSamaritan/BadSamaritan.sol";

contract GoodSamaritanScript is Script {
    function run() external {
        vm.startBroadcast(0x777dcCD91f7C62717DBa44db3504bDf47C75E2F1);

        BadSamaritan robber = new BadSamaritan();
        robber.rob(0x64CbEDC22e8F5296A9d83818182BF525FeF2d76D);

        vm.stopBroadcast();
    }
}
