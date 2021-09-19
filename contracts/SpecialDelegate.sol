pragma solidity 0.8.7;
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract SpecialDelegate {
/* --------- STORAGE --------- */
/*
ERROR CODES:
1 -> DelegationGiven Failed
2 -> SendTokensBack Failed
/*


/* --------- STORAGE --------- */
    uint256 minimumThreshold = 3;
    uint256 selfVoteCount;
    uint256 totalVoteCount;
    address currOwner;


    mapping(uint256 => address) public daoMembers;
    mapping(address => uint256) public daoMemberTokenAmounts;


    mapping(address => Delegate) public delegates;
    mapping(address => uint256) public delegateAmounts;

/* --------- STRUCTS --------- */
    struct Delegate {
        mapping(address => uint256) tokensDelegated;
        uint256 timesVoted;
        bool isActive;
    }

/* --------- EVENTS --------- */

    event DelegateTokensMinted( uint256 indexed totalSupply,  address indexed currentOwner);
    event DelegationGiven(uint256 indexed amountGiven, address indexed sender);
    event Error(uint256 indexed errorCode);

/* --------- MODIFIERS --------- */
    modifier isDelegate(address caller) {
        require(delegates[caller].isActive, "NOT A DELEGATOR");
        _;
    }
    modifier hasEnoughTokens(uint256 amount) {
        require(daoMemberTokenAmounts[msg.sender] >= amount);
        _;
    }

    modifier voteLimitReached() {
        require(selfVoteCount >= totalVoteCount);
        _;
    }
    constructor(uint256 _totalSupply) ERC20("SpecialDelegate", "SPD") {
        _mint(msg.sender, _totalSupply);
        currOwner = msg.sender;
        emit DelegateTokensMinted(_totalSupply, msg.sender);
        totalVoteCount = 0;
        selfVoteCount = 0;
    }


/* --------- FUNCTIONS --------- */


    // DAO member can give tokens to delegate to allow them to vote
    function giveDelegation(address payable _delegate, uint256 _amount) external hasEnoughTokens(_amount) {
        delegateAmounts[_delegate].tokensDelegated[msg.sender] += _amount;
        delegateAmounts[_delegate].isActive += true;
        (bool success, bytes memory data) = _delegate.call{value: _amount}("");
        if (success) {
            emit DelegationGiven(_amount, msg.sender);
        } else {
            emit Error(1);
        }

    }



    // Send tokens back from delegate to DAO member
    function sendTokensBackToMember() private voteLimitReached {

    }

    function transferDelegation(uint256 amount, address _to) public {
        require(msg.sender == currOwner, "Only the owner of these tokens can make this call");
        delegate(_to);
        uint256 prevAmount = ownerAmounts[msg.sender];
        ownerAmounts[msg.sender] = prevAmount - amount;
        transferFrom(msg.sender, _to,amount);

    }

    function updateVotes(bool didVote) public {
        // require(<maloch contract address will go here>);
        if (didVote) {
            selfVoteCount += 1;
        }
        totalVoteCount += 1;
        checkIfShouldReturn();
    }
    function checkIfShouldReturn()  internal {
        int voteRatio = int(selfVoteCount - totalVoteCount);
        if (voteRatio < minimumThreshold) {
            transferFrom(address(this), address(0xd9145CCE52D386f254917e481eB44e9943F39138) ,address(this).balance);
        }
    }

    /**
    @dev Not sure if thiese functions are needed yet
                    |
                    |
                    V

    function voteForMembers() external isDelegate(msg.sender) {

    }

   function mint(address to, uint256 amount) external {
        _mint(to, amount);
    }

*/
}