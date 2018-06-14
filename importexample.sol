/**
 * All the code in this source file has been written by 
 * Achal Singh
 */

//This is the first file
pragma solidity ^0.4.24;

contract Practice1 {

    function f1(uint a, uint b) internal pure returns (uint) {
        return a + b;
    }
}

// This is the second file 
pragma solidity ^0.4.24;

//Importing the first file
import "browser/practice1.sol";

contract Practice2 is Practice1 {
     
    uint public sum;
    
    function getResult (uint x,uint y) public view returns (uint){
        sum = f1(x,y);
        return sum;
    }
    
}