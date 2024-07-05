// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {IGoodSamaritan, BadSamaritan} from "src/GoodSamaritan/BadSamaritan.sol";

contract GoodSamaritanTest is Test {
    function testRob() public {
        BadSamaritan robber = new BadSamaritan();
        robber.rob(0x64CbEDC22e8F5296A9d83818182BF525FeF2d76D);

        //assert that coin balance is 0 or robber got all the money
    }
}
