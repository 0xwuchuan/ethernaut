// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Test, console} from "forge-std/Test.sol";
import {AttackMotorbike} from "src/Motorbike/AttackMotorbike.sol";

contract MotorbikeTest is Test {
    function testAttack() public {
        AttackMotorbike attack = new AttackMotorbike();
        attack.pwn(0xCC583AA7838ac92bE2599c64ADF8E193Ff89304b);
    }
}
