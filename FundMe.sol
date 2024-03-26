 // SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0; 
 
contract   FundMe{
   address payable  public owner;
   mapping(address=>uint) fundersDetail;
   address[] public funders;
  

   constructor(){    ///// special type of function use in initalizing the state variables execute on deploy time 
     owner=  payable (msg.sender);
   }

    function isFunderExists(address _element) private view returns (bool) {///// function for ensuring  unique funders adress
        for (uint i = 0; i < funders.length; i++) {
            if (funders[i] == _element) {
                return false;
            }
        }
        return true;
    }


    receive() external payable {///// function for collecting fund to contract adress
     require(msg.value >= 1 ether,"Please send enough amount");////////// payment will not complete if amount is less than 1 ether
     fundersDetail[msg.sender] += msg.value;
     if(isFunderExists(msg.sender)){
      funders.push(msg.sender);
     }
     
    }


    function  totalFundAmount() public view  returns (uint256) { ///for checking contract balance
        require(msg.sender==owner);////// only ownere can check the contract balance

         
        return address(this).balance;/// this means contract
    }

    function withdraw()  public{  /// only owner will able call this function
      require(msg.sender==owner);
      owner.transfer(totalFundAmount());

    }

    function changeOwnership(address payable _newOwner) public{ ///// changing the ownership only current owner can do this 
      require(msg.sender==owner);
      owner= payable (_newOwner);//// ensuring next owner to payable
    }

    function checkOwnerBalance ()  public  view  returns (uint){///// checking owner balance
         require(msg.sender==owner);
         return address(owner).balance;
    }
    
    function noOfFunders() public view returns (uint256){ //// any one can call this to see no of funders
      return funders.length;
    }

}
