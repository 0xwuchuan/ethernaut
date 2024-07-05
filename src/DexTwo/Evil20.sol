// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract Evil20 is ERC20 {
    constructor() ERC20("Evil20", "EVIL") {}

    function mintTokens(address _to, uint256 _value) public {
        _mint(_to, _value);
    }
}
