/**
 * All the code in this source file has been written by 
 * Achal Singh
*/

/** 
 * Case Study Based Program - "Kickstart".
 * Crowdfunding smart contract for startup projects.
 */

pragma solidity ^0.4.24;

contract Kickstart {
    
    address owner;
    uint contractBalance;
    bool icoActive;
    uint highestTokenCount;
    address[] projectsEntered;
    address winnerProject;
    uint time;
    uint projSubmissionFees = 5000000000000000000; //5 Ether
    uint investorEntryFees = 2000000000000000000; //2 Ether
    uint minProjectInvestment = 100000000000000000;//0.1 Ether    \
    uint icoTime = 360; //1 hour
    
    struct Project {
        string proj_name;
        address addr_proj;
        uint minRaise;
        uint deadline;
        uint tokensInvested;
    }
    
    struct Investor {
        address addr_investor;
        uint amountInvested;
    }
    
    constructor() public {
        owner = msg.sender;
        time = now;
    }
    
    mapping (address => Project) project;
    
    //Tokens Invested by a particular investor 
    mapping(address => uint) investment;

    modifier onlyOwner (){
        require(msg.sender == owner, "You are NOT AUTHORIZED!");
        _;
    }
    
    modifier checkICOTime(){
        require(time <= time + icoTime, "ICO has ENDED, SORRY!");
        _;
    }
    
    //Returns the Contract's Ether Balance.
    function showContractBalance() public view returns(uint){
        uint bal = address(this).balance / 1000000000000000000;
        return bal;
    }
    
    //Project submiision function
    function submitProject(string name, address _addr, uint minTargetRaise, uint t) public payable returns(bool){
        if (msg.value >= projSubmissionFees) {
            project[_addr].proj_name = name;
            project[_addr].minRaise = minTargetRaise;
            project[_addr].deadline = t;
            project[_addr].tokensInvested = 0;
            projectsEntered.push(_addr);
            sendFundsToContract(projSubmissionFees);
            return true;
        } else return false;
    }
    
    //Fee Collection function for the contract.
    function sendFundsToContract(uint amount) public {
        address(this).send(amount);
    }
    
    //Check if Project is entered into the system
    function checkIfProjectEntered(address _proj) public view returns (bool) {
        for(uint i=0; i <= projectsEntered.length-1; i++){
            if(projectsEntered[i] == _proj){
                return true;
            }
        }
    }
    
    //Invest ether in a particular project
    function investInProject(address _proj) public checkICOTime payable {
        
        if(checkIfProjectEntered(_proj) && (msg.value >= minProjectInvestment + investorEntryFees)) {
            //Sending funds to Project Address.
            _proj.send(msg.value - investorEntryFees);

            //Sending Investor Entry Fees to Contract Address
            sendFundsToContract(investorEntryFees);
            
            //Adding project investment to tokensInvested field
            project[_proj].tokensInvested += (msg.value - investorEntryFees);
            
            //Computing highestTokenCount
            if(project[_proj].tokensInvested >= highestTokenCount) { 
                highestTokenCount = project[_proj].tokensInvested; 
            }
        }
    }
    
    //END the ICO
    function endICO() public returns(bool){
        icoActive = false;
        return icoActive;
    }
    
    //Return's the maximum funded project's address
    function getWinningProject() public returns(address){
        if(!icoActive){
            for(uint i=0; i < projectsEntered.length; i++){
                if(project[projectsEntered[i]].tokensInvested == highestTokenCount){
                    winnerProject = projectsEntered[i];
                    return winnerProject;// returning the project's address with highest ether investment.
                }
            }
            
        }
    }
    
    //Transfers the reward ether amount from contract to the winning project's address.
    function sendWinningReward() public onlyOwner{
        winnerProject.send(address(this).balance);
    }
}