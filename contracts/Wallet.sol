// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;
import "./Ownable.sol";
import "./Selfdestruct.sol";

contract Wallet is Ownable , selfDestruct{
    
     mapping(address => uint) balance;

     event balanceAdded(uint amount , address depositedTo);
     event transferedTo(address depositeAddress , uint amount);

     function Deposite()payable public returns(uint){
        balance[msg.sender] += msg.value;
        emit balanceAdded(msg.value, msg.sender);
        return balance[msg.sender];
     }

     function CheckBalance() public view returns(uint) {
     return balance[msg.sender];
     }
 
     function Transfer(address payable recipent , uint amount) public onlyOwner returns(uint){

        require(msg.sender != recipent , "Sender is also the reciever");
        require(balance[msg.sender]>= amount , "Insufficent funds");
        uint previousSender = balance[msg.sender];
        balance[msg.sender] -= amount ;
        payable(recipent).transfer(amount) ; 
        emit transferedTo(msg.sender , amount);
        require(balance[msg.sender] == previousSender - amount); 
        return balance[msg.sender];

     }

     function ContractBalance() public view returns(uint){
         return address(this).balance;
     }

     function Withdraw(uint amount) public  {
        require(balance[msg.sender] >= amount , "Insufficent amount of funds");
        payable (msg.sender).transfer(amount) ;
     }
   
   
}