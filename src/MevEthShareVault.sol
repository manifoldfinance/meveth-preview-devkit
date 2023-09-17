// SPDX-License-Identifier: GPL-3.0-or-later
pragma solidity ^0.8.10;

interface MevEthShareVaultInterface {
    event AdminAdded(address indexed newAdmin);
    event AdminDeleted(address indexed oldAdmin);
    event FeesSent(uint256 indexed feesSent);
    event MevEthUpdated(address indexed meveth);
    event OperatorAdded(address indexed newOperator);
    event OperatorDeleted(address indexed oldOperator);
    event ProtocolFeeToUpdated(address indexed newProtocolFeeTo);
    event RewardPayment(uint256 indexed blockNumber, address indexed coinbase, uint256 indexed amount);
    event RewardsCollected(uint256 indexed protocolFeesOwed, uint256 indexed rewardsOwed);
    event RewardsPaid(uint256 indexed rewards);
    event TokenRecovered(address indexed recipient, address indexed token, uint256 indexed amount);
    event ValidatorWithdraw(address sender, uint256 amount);

    function addAdmin(address newAdmin) external;
    function addOperator(address newOperator) external;
    function admins(address) external view returns (bool);
    function deleteAdmin(address oldAdmin) external;
    function deleteOperator(address oldOperator) external;
    function fees() external view returns (uint128);
    function logRewards(uint128 protocolFeesOwed) external;
    function mevEth() external view returns (address);
    function operators(address) external view returns (bool);
    function payRewards() external;
    function payValidatorWithdraw() external;
    function protocolBalance() external view returns (uint128 fees, uint128 rewards);
    function protocolFeeTo() external view returns (address);
    function recoverToken(address token, address recipient, uint256 amount) external;
    function rewards() external view returns (uint128);
    function sendFees() external;
    function setNewMevEth(address newMevEth) external;
    function setProtocolFeeTo(address newProtocolFeeTo) external;
}