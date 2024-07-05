// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GatekeeperOne} from "src/GatekeeperOne/GateKeeperOne.sol";

contract GateUnlockerOne {
    GatekeeperOne door;

    constructor(address _door) {
        door = GatekeeperOne(_door);
    }

    function useKey(uint256 gas) public {
        uint16 k16 = uint16(uint160(tx.origin));

        uint64 k64 = uint64((1 << 63) + uint64(k16));
        bytes8 gateKey = bytes8(k64);

        bool result = door.enter{gas: 8191 * 10 + gas}(gateKey);
        if (!result) revert("youre ass");
    }
}
