crowdFunding Smart Contract
This Solidity smart contract implements a basic crowdfunding platform on the Ethereum blockchain. It allows contributors to fund a project and vote on requests for fund disbursement.

Features
Contribute: Contributors can send Ether to fund the project.
Request Creation: Admin can create requests for fund disbursement, specifying the recipient, amount, and purpose.
Voting: Contributors can vote on whether to approve a request for fund disbursement.
Payment: Admin can finalize a request if it receives more than 50% of votes and transfer the requested funds to the recipient.
Refund: Contributors can reclaim their contribution if the campaign deadline passes without meeting the funding goal.
Requirements
Solidity version: 0.8.7
Ethereum blockchain or test network for deployment and testing
Deployment
Deploy the contract to an Ethereum blockchain or test network.
Set the contract's parameters (goal, deadline, minimumContribution) during deployment.
The deployer becomes the contract admin and can start managing contributions and requests.
Usage
Contributing
Use the contribute() function to send Ether to the contract.
Ensure the contribution meets the minimumContribution and is within the deadline.
Request Creation and Voting
Only the contract admin can create requests using createRequest().
Contributors can vote on requests using voteRequest(requestNumber).
Payment and Refund
Admin can finalize a request using makePayment(requestNumber) once it meets the voting threshold.
Contributors can reclaim their contribution using getRefund() after the deadline if the goal is not met.
Events
ContributeEvent: Emits when a contribution is made.
CreateRequestEvent: Emits when a request for fund disbursement is created.
MakePaymentEvent: Emits when a payment is made to a recipient.
