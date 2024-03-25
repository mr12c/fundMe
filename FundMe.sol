// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0; 
 
contract   FundMe{
   address payable  public owner;
   mapping(address=>uint) fundersDetail;
   address[] public funders;
  

   constructor(){    ///// special type of function use in initalizing the state variables execute on deploy time 
     owner=  payable (msg.sender);
   }

    function isFunderExists(address _element) public view returns (bool) {
        for (uint i = 0; i < funders.length; i++) {
            if (funders[i] == _element) {
                return false;
            }
        }
        return true;
    }


    receive() external payable {
     require(msg.value >= 1 ether);
     fundersDetail[msg.sender] += msg.value;
     if(isFunderExists(msg.sender)){
      funders.push(msg.sender);
     }
     
    }


    function checkContractAmount() public view  returns (uint256) {
        require(msg.sender==owner);

        uint256 amount=0;
        for(uint i=0;i<funders.length;i++){
           amount+=fundersDetail[funders[i]];
        }
        return address(this).balance;
    }

    function transferToOwner()  public{
      require(msg.sender==owner);
      owner.transfer(checkContractAmount());

    }

    function changeTheOwnership(address payable _newOwner) public{
      require(msg.sender==owner);
      owner= payable (_newOwner);
    }

    function checkOwnerBalance ()  public  view  returns (uint){
         return address(owner).balance;
    }
    
    function getFundersLength() public view returns (uint256){
      return funders.length;
    }

}