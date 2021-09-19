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
    mapping(address => bool) public isDelegate;
    mapping(address => uint256) public delegateAmounts; // to keep track of the amount of delegation tokens each delegate has

/* --------- STRUCTS --------- */
//
    struct DAOMember {
        Delegate delegate;
        uint256 tokenAmount;
        address _address;
    }

    struct Delegate {
        uint256 tokensDelegated; // number of tokens delegated with the DAO member that delegated that amount as the key
        uint256 timesVoted;
        bool isActive;
        address _address;
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
        // function that allows DAO members to give their tokens to a delegate

        // if a this address is already a Delegate, add to their existing amount of tokens for voting. Else, create a new struct called Delegate and then add the amount that is sent from the caller

        // once the delegate's token amount are updated, actually send the tokens to the delegate address

       // if successful, emit an event that says tokens were delegated and if not then emit and Error event
    }



    // Send tokens back from delegate to DAO member
    function sendTokensBackToMember() private voteLimitReached {
        // sendsTokens back to DAO member from delegate that has them
    }

    function transferDelegation(uint256 amount, address _to) public {
        require(msg.sender == currOwner, "Only the owner of these tokens can make this call");
        // transfersDelegation to another delegate if necessary?

    }

    function updateVotes(bool didVote) public {
        // udpates the number of votes that have been executed on chain and also checks if tokens need to be returned
        // checkIfShouldReturn();
    }
    function checkIfShouldReturn()  internal {
       // check if the tokens should go back to the DAO member if the conditions for a delegate to need to release their tokens are met
    }


}