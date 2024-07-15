// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IDetectionBot {
    function handleTransaction(address user, bytes calldata msgData) external;
}

interface IForta {
    function setDetectionBot(address detectionBotAddress) external;

    function notify(address user, bytes calldata msgData) external;

    function raiseAlert(address user) external;
}

contract DetectionBot is IDetectionBot {
    address private cryptoVault;

    constructor(address _cryptoVault) {
        cryptoVault = _cryptoVault;
    }

    /* Structure of calldata received:
    [000]: 0x220ab6aa (func selector of handleTransaction)
    [004]: 000000000000000000000000777dccd91f7c62717dba44db3504bdf47c75e2f1 (address user)
    [024]: 0000000000000000000000000000000000000000000000000000000000000040 (offset of msgData)
    [044]: 0000000000000000000000000000000000000000000000000000000000000064 (length of msgData)
    [064]: 9cd1a121 (func selector of delegateTransfer)
    [068]: 000000000000000000000000777dccd91f7c62717dba44db3504bdf47c75e2f1 (address to)
    [088]: 0000000000000000000000000000000000000000000000056bc75e2d63100000 (uint256 value)
    [0a8]: 000000000000000000000000239de36e1f1b209eb4defe8bf4a41c791853307a (address origSender)
    [0c8]: 00000000000000000000000000000000000000000000000000000000
    */
    function handleTransaction(
        address user,
        bytes calldata msgData
    ) external override {
        address origSender;
        assembly {
            origSender := calldataload(0xa8)
        }

        if (origSender == cryptoVault) {
            IForta(msg.sender).raiseAlert(user);
        }
    }
}
