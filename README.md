# Project Idea (Chapter 1 Response)

## Background
Not everyone can or wants to be highly engaged in DAO governance at all times. This makes governance delegation a solution. The problem no is, how do we ensure that we are selecting the best actors to delegate our governance?

## Purpose 
The purpose around this is that we want to empower those who will be active delegates in DAO governance and weed out those who will not use their voting power responisbly. If they are not exercising their voting power on a regular basis, they will be punished by slashing their delegation power. We want this to be flexible enough however for actors to realize when they may not be a suitable fit and give them the ability to pass their delegation off to another.

## Spec
I have been thinking about my final project idea and have a couple. 
One is something around governance delegation. 
Not sure if this is out there but I have an idea for a governance token, call it `SpecialDelegate` for now. Say this token has two counters: 
- first counter (`uint256 public numberTimesVoted;`) 
- and a second counter (`uint256 public totalNumberOfVotes`) that represents the number of votes executed since the minting of `SpecialDelegate` token or since the last time it was transferred to another address.

Let us also say there is a minimum ratio that these two numbers can be at for the token to not be destroyed or slashed (`public int minimumThreshold`)

Now we can say that people can allocate these tokens to people they believe would be good delegators for them. Everytime there is a vote executed on chain through a gnosis safe or maloch dao, the contract can call a function (`checkVoteCount`) to these SpecialDelegate tokens and  the SpecialDelegates will run the following :
  1. Did this token get used in the last vote? If NO -> do NOT increment `numberTimesVoted` else increment `numberTimesVoted`
  2. Increment the `totalNumberOfVotes` 
  3. set `minimumThreshold = numberOfTimesVoted / totalNumberOfVotes` 
  4. Check to see if the `minimumThreshold` is too low. If YES -> Slash `SpecialDelegate` else do nothing
 
 Another aspect of this token is that when it is transfered to another address, the follwing should happen:
 
  1. Check if the address was the most recent owner and revert transfer if this is the case (we want to protect against people passing the tokens between two different addresses to reset the ratio).
  2. `totalNumberOfVotes` and `numberOfTimesVoted` should be reset so the new delegator is not at a disadvantage in terms of what the previous ratio of the `minimumThreshold` was for the previous owner.


## Questions that still need to be answered or fleshed out
1. What if a person has more than two addresses?
2. What should the `minimumThreshold` be
3. How does the gnosis safe or maloch dao (or wherever the onchain execution occurs) make the call to all of these tokens?
