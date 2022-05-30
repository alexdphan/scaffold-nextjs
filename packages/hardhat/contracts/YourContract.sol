pragma solidity >=0.8.0 <0.9.0;
//SPDX-License-Identifier: MIT

// Primitive Data Types - 
// Mappings - 
// Structs
// Modifiers -
// Events
// Inheritance -
// Payable - 
// Fallback
// Just make it work for now

import "hardhat/console.sol";

// This Ownable.sol contract from Openzeppelin is for example, inheritance for ownership
// In this example, we decided to use a modifier instead
// import "@openzeppelin/contracts/access/Ownable.sol"; 
// https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/access/Ownable.sol



contract YourContract {

    uint internal sum;
    string public name = "Alex";
    address public owner = 0x01c6fd9Ef45B69A24d3D59bEEbDc87c9c59dF2c7;
    string public purpose = "Building Unstoppable Apps!";
    // event SetPurpose(address sender, string purpose);
    // event SenderLogger(address);
    // event ValueLogger(uint);

    mapping(address => uint) public balance;

    // showing that the owner has a balance of 100
    constructor() {
    balance[owner] = 250000;
  }

  // Transferring balances using the mapping balance
   function transfer(address to, uint amount) public {
    require(balance[msg.sender] >= amount, "Not enough.. You broke?");
    balance[msg.sender] -= amount;
    balance[to] += amount;
  }

    // Modifier to check that the caller is the owner of
    // the contract.
    // THIS IS GIVEN THAT THE YOU ALREADY ARE THE OWNER IN THE FIRST PLACE, OTHERWISE, THIS WON'T WORK.
    modifier onlyOwner() {
        require(msg.sender == owner, "Not owner");
        // Underscore is a special character only used inside
        // a function modifier and it tells Solidity to
        // execute the rest of the code.
        _;
    }
    // modifier checking if this is a valid address
    modifier validAddress(address _addr) {
      require(_addr != address(0), "This isn't a valid address boi");
      _;
    }

  // inserting two modifiers into this function (onlyOwner and validAddress)
  // This is saying the owner can only change who the new owner will become
  function changeOwner(address _newOwner) public onlyOwner validAddress(_newOwner) {
    owner = _newOwner;
  }

  // Changes the message of setPurpose if you pay 0.001 ether to the contract itself
  function setPurpose(string memory newPurpose) public payable{
    require(msg.value == 0.001 ether, "It's not enough ;/");
    // after effect happens here on before the action
    purpose = newPurpose;
    console.log(msg.sender, "set purpose to", purpose);
  }

  // withdraw function only if you are the owner
}

