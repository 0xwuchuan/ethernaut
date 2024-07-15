// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {DoubleEntryPoint, CryptoVault, LegacyToken} from "src/DoubleEntryPoint/DoubleEntryPoint.sol";
import {DetectionBot} from "src/DoubleEntryPoint/DetectionBot.sol";
import {IERC20} from "@openzeppelin/contracts/interfaces/IERC20.sol";

contract DoubleEntryPointTest is Test {
    function testLog() public {
        DoubleEntryPoint target = DoubleEntryPoint(
            0x584d59c40810243e1E14E85bFbb88399d7D64046
        );

        CryptoVault vault = CryptoVault(target.cryptoVault());
        vault.underlying(); //0x584d59c40810243e1E14E85bFbb88399d7D64046

        LegacyToken legacy = LegacyToken(target.delegatedFrom()); //0x337a5de0Fec04BE33c0C09Cd596Cf744BA3544bF

        legacy.delegate(); //0x584d59c40810243e1E14E85bFbb88399d7D64046
    }

    function testAttack() public {
        vm.startBroadcast();

        DoubleEntryPoint target = DoubleEntryPoint(
            0x5e06D783fD48ce06a4829660E3E4b8E5fb969505
        );
        console.log(target.cryptoVault());
        DetectionBot bot = new DetectionBot(target.cryptoVault());
        target.forta().setDetectionBot(address(bot));

        CryptoVault vault = CryptoVault(target.cryptoVault());
        vault.sweepToken(IERC20(target.delegatedFrom()));

        vm.stopBroadcast();
    }
}
