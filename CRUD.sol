/**
 * All the code in this source file has been written by 
 * Achal Singh
 */

//CRUD -(Create, Read, Update & Delete) PROGRAM

pragma solidity ^0.4.24;

contract Crud {

    struct User {
        string email;
        address userAddress;
        string name;
    }
    //Taking the email id of the user as the index.
    mapping(string => User) a;

    //Create a new entry.
    function create (string mail, address addr, string nam) public {
        a[mail].email = mail;
        a[mail].userAddress = addr;
        a[mail].name = nam;
    }
    
    //Read from an existing entry.
    function read (string mail) public view returns (string first, address second, string third) {
        first = a[mail].email;
        second = a[mail].userAddress;
        third = a[mail].name;
    }
    
    //Update existing entry (if not present, creates a new entry).
    function update (string mail, address addr, string name) public  {
        create (mail, addr, name); 
    }
    
    //Deletes the entire entry associated with the particular email address. 
    function del (string mail) public {
        delete a[mail];
    }
}