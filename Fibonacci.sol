/**
 * All the code in this source file has been written by 
 * Achal Singh
 */

//Fibonacci Series (Function call-wise execution).
pragma solidity ^0.4.24;

contract Fibo {
    uint x = 0;
    uint y = 0;
    uint res;
    
    function f() public returns (uint){
        if(y == 0) {
            y++;
            return res; 
        }
        else iter();
        return res;
    }

    //All the iterations (after the first one) are executed here. 
    function iter() public returns (uint) {
        res = x + y; 
        y = x;
        x = res;
        return res;
    }
    
    //Returns the fibonacci result.
    function getRes() public view returns(uint){
        return res;
    }
        
}
