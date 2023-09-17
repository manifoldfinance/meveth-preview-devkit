pragma solidity ^0.8.10;

interface Interface {
    event AdminAdded(address indexed newAdmin);
    event AdminDeleted(address indexed oldAdmin);
    event Approval(address indexed owner, address indexed spender, uint256 amount);
    event CallOFTReceivedSuccess(uint16 indexed _srcChainId, bytes _srcAddress, uint64 _nonce, bytes32 _hash);
    event CreamRedeemed(address indexed redeemer, uint256 creamAmount, uint256 mevEthAmount);
    event Deposit(address indexed caller, address indexed owner, uint256 assets, uint256 shares);
    event MessageFailed(uint16 _srcChainId, bytes _srcAddress, uint64 _nonce, bytes _payload, bytes _reason);
    event MevEthInitialized(address indexed mevEthShareVault, address indexed stakingModule);
    event MevEthShareVaultUpdateCanceled(address indexed oldVault, address indexed newVault);
    event MevEthShareVaultUpdateCommitted(
        address indexed oldVault, address indexed pendingVault, uint64 indexed eligibleForFinalization
    );
    event MevEthShareVaultUpdateFinalized(address indexed oldVault, address indexed newVault);
    event NonContractAddress(address _address);
    event OperatorAdded(address indexed newOperator);
    event OperatorDeleted(address indexed oldOperator);
    event ReceiveFromChain(uint16 indexed _srcChainId, address indexed _to, uint256 _amount);
    event RetryMessageSuccess(uint16 _srcChainId, bytes _srcAddress, uint64 _nonce, bytes32 _payloadHash);
    event Rewards(address sender, uint256 amount);
    event SendToChain(uint16 indexed _dstChainId, address indexed _from, bytes32 indexed _toAddress, uint256 _amount);
    event SetDefaultFeeBp(uint16 feeBp);
    event SetFeeBp(uint16 dstchainId, bool enabled, uint16 feeBp);
    event SetFeeOwner(address feeOwner);
    event SetMinDstGas(uint16 _dstChainId, uint16 _type, uint256 _minDstGas);
    event SetPrecrime(address precrime);
    event SetTrustedRemote(uint16 _remoteChainId, bytes _path);
    event SetTrustedRemoteAddress(uint16 _remoteChainId, bytes _remoteAddress);
    event SetUseCustomAdapterParams(bool _useCustomAdapterParams);
    event StakingModuleUpdateCanceled(address indexed oldModule, address indexed pendingModule);
    event StakingModuleUpdateCommitted(
        address indexed oldModule, address indexed pendingModule, uint64 indexed eligibleForFinalization
    );
    event StakingModuleUpdateFinalized(address indexed oldModule, address indexed newModule);
    event StakingPaused();
    event StakingUnpaused();
    event Transfer(address indexed from, address indexed to, uint256 amount);
    event ValidatorCreated(address indexed stakingModule, ValidatorData newValidator);
    event ValidatorWithdraw(address sender, uint256 amount);
    event Withdraw(
        address indexed caller, address indexed receiver, address indexed owner, uint256 assets, uint256 shares
    );
    event WithdrawalQueueClosed(address indexed recipient, uint256 indexed withdrawalId, uint256 assets);
    event WithdrawalQueueOpened(address indexed recipient, uint256 indexed withdrawalId, uint256 assets);

    struct LzCallParams {
        address refundAddress;
        address zroPaymentAddress;
        bytes adapterParams;
    }

    struct ValidatorData {
        address operator;
        bytes pubkey;
        bytes32 withdrawal_credentials;
        bytes signature;
        bytes32 deposit_data_root;
    }

    function BP_DENOMINATOR() external view returns (uint256);
    function CREAM_TO_MEV_ETH_PERCENT() external view returns (uint256);
    function DEFAULT_PAYLOAD_SIZE_LIMIT() external view returns (uint256);
    function DOMAIN_SEPARATOR() external view returns (bytes32);
    function MIN_DEPOSIT() external view returns (uint128);
    function NO_EXTRA_GAS() external view returns (uint256);
    function PT_SEND() external view returns (uint8);
    function PT_SEND_AND_CALL() external view returns (uint8);
    function WETH9() external view returns (address);
    function addAdmin(address newAdmin) external;
    function addOperator(address newOperator) external;
    function admins(address) external view returns (bool);
    function allowance(address, address) external view returns (uint256);
    function approve(address spender, uint256 amount) external returns (bool);
    function asset() external view returns (address assetTokenAddress);
    function balanceOf(address) external view returns (uint256);
    function calculateNeededEtherBuffer() external view returns (uint256);
    function callOnOFTReceived(
        uint16 _srcChainId,
        bytes memory _srcAddress,
        uint64 _nonce,
        bytes32 _from,
        address _to,
        uint256 _amount,
        bytes memory _payload,
        uint256 _gasForCall
    ) external;
    function cancelUpdateMevEthShareVault() external;
    function cancelUpdateStakingModule() external;
    function chainIdToFeeBps(uint16) external view returns (uint16 feeBP, bool enabled);
    function circulatingSupply() external view returns (uint256);
    function claim(uint256 withdrawalId) external;
    function commitUpdateMevEthShareVault(address newMevEthShareVault) external;
    function commitUpdateStakingModule(address newModule) external;
    function convertToAssets(uint256 shares) external view returns (uint256 assets);
    function convertToShares(uint256 assets) external view returns (uint256 shares);
    function creamToken() external view returns (address);
    function createValidator(ValidatorData memory newData, bytes32 latestDepositRoot) external;
    function creditedPackets(uint16, bytes memory, uint64) external view returns (bool);
    function decimals() external view returns (uint8);
    function defaultFeeBp() external view returns (uint16);
    function deleteAdmin(address oldAdmin) external;
    function deleteOperator(address oldOperator) external;
    function deposit(uint256 assets, address receiver) external payable returns (uint256 shares);
    function estimateSendFee(
        uint16 _dstChainId,
        bytes32 _toAddress,
        uint256 _amount,
        bool _useZro,
        bytes memory _adapterParams
    ) external view returns (uint256 nativeFee, uint256 zroFee);
    function failedMessages(uint16, bytes memory, uint64) external view returns (bytes32);
    function feeOwner() external view returns (address);
    function finalizeUpdateMevEthShareVault(bool isMultisig) external;
    function finalizeUpdateStakingModule() external;
    function forceResumeReceive(uint16 _srcChainId, bytes memory _srcAddress) external;
    function fraction() external view returns (uint128 elastic, uint128 base);
    function getConfig(uint16 _version, uint16 _chainId, address, uint256 _configType)
        external
        view
        returns (bytes memory);
    function getTrustedRemoteAddress(uint16 _remoteChainId) external view returns (bytes memory);
    function grantRewards() external payable;
    function grantValidatorWithdraw() external payable;
    function init(address initialShareVault, address initialStakingModule) external;
    function initialized() external view returns (bool);
    function isTrustedRemote(uint16 _srcChainId, bytes memory _srcAddress) external view returns (bool);
    function lzEndpoint() external view returns (address);
    function lzReceive(uint16 _srcChainId, bytes memory _srcAddress, uint64 _nonce, bytes memory _payload) external;
    function maxDeposit(address) external view returns (uint256 maxAssets);
    function maxMint(address) external view returns (uint256 maxShares);
    function maxRedeem(address owner) external view returns (uint256 maxShares);
    function maxWithdraw(address owner) external view returns (uint256 maxAssets);
    function mevEthShareVault() external view returns (address);
    function minDstGasLookup(uint16, uint16) external view returns (uint256);
    function mint(uint256 shares, address receiver) external payable returns (uint256 assets);
    function name() external view returns (string memory);
    function nonblockingLzReceive(uint16 _srcChainId, bytes memory _srcAddress, uint64 _nonce, bytes memory _payload)
        external;
    function nonces(address) external view returns (uint256);
    function operators(address) external view returns (bool);
    function pauseStaking() external;
    function payloadSizeLimitLookup(uint16) external view returns (uint256);
    function pendingMevEthShareVault() external view returns (address);
    function pendingMevEthShareVaultCommittedTimestamp() external view returns (uint64);
    function pendingStakingModule() external view returns (address);
    function pendingStakingModuleCommittedTimestamp() external view returns (uint64);
    function permit(address owner, address spender, uint256 value, uint256 deadline, uint8 v, bytes32 r, bytes32 s)
        external;
    function precrime() external view returns (address);
    function previewDeposit(uint256 assets) external view returns (uint256 shares);
    function previewMint(uint256 shares) external view returns (uint256 assets);
    function previewRedeem(uint256 shares) external view returns (uint256 assets);
    function previewWithdraw(uint256 assets) external view returns (uint256 shares);
    function processWithdrawalQueue(uint256 newRequestsFinalisedUntil) external;
    function queueLength() external view returns (uint256);
    function quoteOFTFee(uint16 _dstChainId, uint256 _amount) external view returns (uint256 fee);
    function redeem(uint256 shares, address receiver, address owner) external returns (uint256 assets);
    function redeemCream(uint256 creamAmount) external;
    function requestsFinalisedUntil() external view returns (uint256);
    function retryMessage(uint16 _srcChainId, bytes memory _srcAddress, uint64 _nonce, bytes memory _payload)
        external
        payable;
    function sendFrom(
        address _from,
        uint16 _dstChainId,
        bytes32 _toAddress,
        uint256 _amount,
        uint256 _minAmount,
        LzCallParams memory _callParams
    ) external payable;
    function setConfig(uint16 _version, uint16 _chainId, uint256 _configType, bytes memory _config) external;
    function setDefaultFeeBp(uint16 _feeBp) external;
    function setFeeBp(uint16 _dstChainId, bool _enabled, uint16 _feeBp) external;
    function setFeeOwner(address _feeOwner) external;
    function setMinDstGas(uint16 _dstChainId, uint16 _packetType, uint256 _minGas) external;
    function setPayloadSizeLimit(uint16 _dstChainId, uint256 _size) external;
    function setPrecrime(address _precrime) external;
    function setReceiveVersion(uint16 _version) external;
    function setSendVersion(uint16 _version) external;
    function setTrustedRemote(uint16 _remoteChainId, bytes memory _path) external;
    function setTrustedRemoteAddress(uint16 _remoteChainId, bytes memory _remoteAddress) external;
    function setUseCustomAdapterParams(bool _useCustomAdapterParams) external;
    function sharedDecimals() external view returns (uint8);
    function stakingModule() external view returns (address);
    function stakingPaused() external view returns (bool);
    function supportsInterface(bytes4 interfaceId) external view returns (bool);
    function symbol() external view returns (string memory);
    function token() external view returns (address);
    function totalAssets() external view returns (uint256 totalManagedAssets);
    function totalSupply() external view returns (uint256);
    function transfer(address to, uint256 amount) external returns (bool);
    function transferFrom(address from, address to, uint256 amount) external returns (bool);
    function trustedRemoteLookup(uint16) external view returns (bytes memory);
    function unpauseStaking() external;
    function useCustomAdapterParams() external view returns (bool);
    function withdraw(uint256 assets, address receiver, address owner) external returns (uint256 shares);
    function withdrawQueue(uint256 assets, address receiver, address owner) external returns (uint256 shares);
    function withdrawalAmountQueued() external view returns (uint256);
    function withdrawalQueue(uint256 ticketNumber)
        external
        view
        returns (bool claimed, address receiver, uint128 amount, uint128 accumulatedAmount);
}