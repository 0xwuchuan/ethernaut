// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {IBuyer, Shop} from "src/Shop/Shop.sol";
import {Buyer} from "src/Shop/Buyer.sol";

contract ShopTest is Test {
    Shop shop;
    Buyer buyer;

    function setUp() public {
        shop = Shop(0xE7326468e592BFd641F481402DE8E52c8a7B48A9);
        buyer = new Buyer(0xE7326468e592BFd641F481402DE8E52c8a7B48A9);
    }

    function testBuy() public {
        vm.prank(address(buyer));

        shop.buy();
        assertEq(shop.price(), 99);
    }
}
