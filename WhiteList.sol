pragma solidity ^0.4.24;

contract WhiteList {
    
    uint icoTime = 36000; //10 hrs 
    uint time;
    uint count = 0;
    uint public c;
    address owner;
    address[] userWhiteList;

    /* Initializes contract with initial supply tokens to the creator of the contract */
    constructor() public payable {
        owner = msg.sender;
        time = now;
    }
    
    modifier checkOwner(){
        require(msg.sender == owner, "You are NOT Authorised!");
        _;
    }
    
    modifier checkTime(){
        require(now<=time + icoTime, "The ICO is closed!");
        _;
    }
    
    function checkIfInWhiteList (address _user) public returns (uint){
        c=0;
        for (uint k=0; k < userWhiteList.length; k++){
            if (userWhiteList[k] == _user) {c++; return c;} 
        }
        
    }
    // To send the balance in the Contract to the Contract Owner.
    function send () public payable returns (string){
        owner.send(address(this).balance);
        return "Successfully transfered!";
    }
    
    function getBal() public view returns (uint){
        return address(this).balance;
    }
    

    /* Send coins */
    function () public payable {
        c = checkIfInWhiteList(msg.sender);
        if (c == 1)  address(this).send(msg.value);
    }
    
    function addToWhitelist(address _user) public checkTime checkOwner{
        userWhiteList.push(_user);
    }
}