// SPDX-License-Identifier: MIT
pragma solidity 0.8.7;
contract crowdFunding
{
    mapping (address => uint) public contributors;
    uint public noOfContributors;
    address public admin;
    uint public minimumContribution;
    uint public goal;
    uint public deadline;
    uint public raisedAmount;

    struct Request{
        string description;
        address payable recipient;
        uint value;
        uint noOfVoters;
        bool completed;
        mapping (address => bool) voters;

    }

    mapping (uint => Request) public requests;
    uint public numRequests;

    event ContributeEvent(address _sender, uint _value);
    event CreateRequestEvent(string _description, address _recipient, uint _value);
    event MakePaymentEvent(address _recipient, uint _value);

    constructor(uint _goal, uint _deadline)
    {
        goal=_goal;
        deadline = block.timestamp + _deadline;
        admin= msg.sender;
        minimumContribution =  100 wei;
    }

    modifier onlyOwner()
    {
        require(msg.sender ==  admin, "YOU MUST BE AN ADMIN");
        _;
    }

    function contribute() public payable 
    {
        require(block.timestamp < deadline,"DEADLINE PASSED");
        require(msg.value >= minimumContribution , "MINIMUM CONTRIBUTION NOT MET");
        if(contributors[msg.sender] == 0)
        {
            noOfContributors++;
        }

        contributors[msg.sender]+= msg.value;
        raisedAmount+= msg.value;
        emit ContributeEvent(msg.sender,msg.value);

    }

    function getBalance() public view returns(uint)
    {
        return address(this).balance;
    }

    function getRefund() public 
    {
        require(block.timestamp > deadline , "DEADLINE HAS NOT PASSED");
        require(raisedAmount< goal," GOAL HAS MET");
        require(contributors[msg.sender]>0);
        address payable recipient= payable(msg.sender);
        uint value=contributors[msg.sender];
        contributors[msg.sender]=0;
        recipient.transfer(value);

    }

    function createRequest(string calldata _description, address payable _recipient, uint _value) public onlyOwner
    {
        Request storage newRequest= requests[newRequest];
        numRequests++;
        numRequests._description= _description;
        numRequests.recipient = _recipient;
        numRequests.value= _value;
        numRequests.completed= false;
        numRequests.noOfContributors=0;

        emit CreateRequestEvent(_description, _recipient, _value);

    }

    function voteRequest(uint _requestNo) public 
    {
        require(contributors[msg.sender]>0,"YOU MUST BE A CONTRIBUTOR");
        Request storage thisRequest= requests[_requestNo];
        require(thisRequest.voters[msg.sender]== false,"YOU ALREADY VOTED");
        thisRequest.voters=true;
        thisRequest.noOfVoters++;
    }

    function makePayment(uint _requestNo) public onlyOwner
    {
        Request storage thisRequest = requests[_requestNo];
        require(thisRequest.completed== false,"REQUEST IS COMPLETED");
        require(thisRequest.noOfVoters > noOfContributors/2 , "YOU NEED MORE THAN 50% VOTES");
        thisRequest.completed=true;
        thisRequest.recipient.transfer(thisRequest.value);

        emit MakePaymentEvent(thisRequest.recipient, thisRequest.value);

    }
    
}
