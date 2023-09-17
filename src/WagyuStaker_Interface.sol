pragma solidity ^0.8.10;

interface Interface {
    event AdminAdded(address indexed newAdmin);
    event AdminDeleted(address indexed oldAdmin);
    event MevEthUpdated(address indexed meveth);
    event NewValidator(
        address indexed operator,
        bytes pubkey,
        bytes32 withdrawalCredentials,
        bytes signature,
        bytes32 deposit_data_root
    );
    event OperatorAdded(address indexed newOperator);
    event OperatorDeleted(address indexed oldOperator);
    event RewardsPaid(uint256 indexed amount);
    event TokenRecovered(address indexed recipient, address indexed token, uint256 indexed amount);
    event ValidatorWithdraw(address sender, uint256 amount);

    struct ValidatorData {
        address operator;
        bytes pubkey;
        bytes32 withdrawal_credentials;
        bytes signature;
        bytes32 deposit_data_root;
    }

    function BEACON_CHAIN_DEPOSIT_CONTRACT() external view returns (address);
    function VALIDATOR_DEPOSIT_SIZE() external view returns (uint256);
    function addAdmin(address newAdmin) external;
    function addOperator(address newOperator) external;
    function admins(address) external view returns (bool);
    function batchMigrate(ValidatorData[] memory batchData) external;
    function deleteAdmin(address oldAdmin) external;
    function deleteOperator(address oldOperator) external;
    function deposit(ValidatorData memory data, bytes32 latestDepositRoot) external payable;
    function mevEth() external view returns (address);
    function operators(address) external view returns (bool);
    function payRewards(uint256 rewards) external;
    function payValidatorWithdraw() external;
    function record()
        external
        view
        returns (
            uint128 totalDeposited,
            uint128 totalWithdrawn,
            uint128 totalRewardsPaid,
            uint128 totalValidatorExitsPaid
        );
    function recoverToken(address token, address recipient, uint256 amount) external;
    function registerExit() external;
    function setNewMevEth(address newMevEth) external;
    function validators() external view returns (uint256);
}