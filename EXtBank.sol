 pragma solidity ^0.8.0;

 contract Bank{
     string bank_name;
     string bank_address;

     mapping(address=>uint) account_balances;


    /* function bank_balance() public view returns (uint){
        return address(this).balance;
    }*/

     function get_balance() external view returns (uint){
        return account_balances[msg.sender];
     }

    /* constructor(){
         bank_address = '4215 Saudi Street';
         bank_name = 'Ayat Bank';
     }*/

     function transfer(address recipint, uint amount) public  {
        // require(account_balances[msg.sender]>amount,"insufficent Funds");
         account_balances[msg.sender]-=amount;
         account_balances[recipint]+= amount;
       //  return true;
     }

     function withdraw(uint amount) public{
        // require(account_balances[msg.sender]>amount,"insufficent Funds");
         account_balances[msg.sender]-=amount;
         payable(msg.sender).transfer(amount);
        // return true;
     }
     receive() external payable{
         account_balances[msg.sender]+= msg.value;
     }
     }

contract FunBank {

    uint number_of_accounts;
     mapping(address=>uint) account_balances;
     mapping(address=>uint) account_info_map;

     struct BankAccountRecord {
         uint account_number;
         string fullName;
         string profession;
         string DateOfBrith;
         address wallet_addr;
         string customer_addr;

     }

     BankAccountRecord[] BankAccountRecords;

     function register_account(string memory fullName_ , string memory profession_ , string memory DateOfBrith_ ,string memory customer_addr_) external{

         require (account_info_map[msg.sender]==0, "Account already Registered ");
         BankAccountRecords.push(
             BankAccountRecord({
                account_number: ++number_of_accounts,
                 fullName: fullName_,
                 profession: profession_,
                 DateOfBrith: DateOfBrith_,
                 wallet_addr: msg.sender,
                 customer_addr: customer_addr_
             })
         );

         account_info_map[msg.sender] = number_of_accounts;

     }

     modifier onlayRegistered() {
         require(account_info_map[msg.sender] > 0, "User not Register, please Register to use this method");
         _;
     }

    /* function bank_balance() public view returns (uint){
        return address(this).balance;
    }*/

     function get_balance() external view onlayRegistered returns (uint){
        return account_balances[msg.sender];
     }

    /* constructor(){
         bank_address = '4215 Saudi Street';
         bank_name = 'Ayat Bank';
     }*/

     function transfer(address recipint, uint amount) public onlayRegistered {
        // require(account_balances[msg.sender]>amount,"insufficent Funds");
         account_balances[msg.sender]-=amount;
         account_balances[recipint]+= amount;
       //  return true;
     }

     function withdraw(uint amount) public onlayRegistered{
        // require(account_balances[msg.sender]>amount,"insufficent Funds");
         account_balances[msg.sender]-=amount;
         payable(msg.sender).transfer(amount);
        // return true;
     }
     receive() external payable{
         account_balances[msg.sender]+= msg.value;
     }


 }

