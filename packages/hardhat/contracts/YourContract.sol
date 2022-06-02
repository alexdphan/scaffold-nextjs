pragma solidity >=0.6.0 <0.9.0;
// SPDX-License-Identifier: MIT

// Primitive Data Types - 
// Mappings - 
// Structs - 
// Modifiers -
// Events - put on the blockchain once and never retreive it
// Inheritance -
// Payable - 
// Fallback - Executed when function DNE, directly sends ETH (when stated as payable)
   // Fallback executed when data isn't empty, Receive will be called when data is empty
   // If fallback function only exists and doesn't have data, it will be executed
   //    Which function is called, fallback() or receive()?

   //         send Ether
   //             |
   //         msg.data is empty?
   //             /       \
   //           yes        no
   //           /           \
   //  receive() exists?     fallback()
   //         /     \
   //     yes        no
   //     /           \
   // receive()      fallback()

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
    event SetPurpose(address sender, string purpose);
    event SenderLogger(address);
    event ValueLogger(uint);
    event Log(string func, address sender, uint value, bytes data);

    mapping(address => uint) public balance;

    // showing that the owner has a balance of 100
    constructor() {
    balance[owner] = 250000;
  }

   // Example of a struct
     struct Book { 
      string title;
      string author;
      uint book_id;
   }
   // declaring a variable call book
   // the type is specified as the struct named Book (above^)
   Book book;

   // function to input title, author, book id w/ memory
   // set book = inputted book, which is Book
   function setBook(string memory _title, string memory _author, uint _book_id) public {
      book = Book(_title, _author, _book_id);
   }
  //  function to get the book info aftering the setBook function
   function getBookId() public view returns (string memory, string memory, uint) {
      return (book.title, book.author, book.book_id);
   }


  // Transferring balances using the mapping balance
  // using transfer method to send ETH
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
  // Also called emit to put on the blockchain once and never retreive it
  function setPurpose(string memory newPurpose) public payable{
    require(msg.value == 0.001 ether, "It's not enough ;/");
    // after effect happens here on before the action
    purpose = newPurpose;
    console.log(msg.sender, "set purpose to", purpose);
    emit SetPurpose(msg.sender, purpose);
  }

  // withdraw function only if you are the owner
  // takes the smart contract, turns it into an address, and gets the balance from it
  // using call method to send ETH
  function withdraw() public {
    require(msg.sender == owner, "Not the owner.. oof");
    (bool success, ) = owner.call{value: address(this).balance}("");
    require(success, "failed ;(");
  }

  // receive() external payable — for empty calldata (and any value)
  receive() external payable {
    emit Log("receive", msg.sender, msg.value, "");
  }


  // Executed when function DNE, directly sends ETH (optionally payable)
  fallback() external payable {
    emit Log("fallback", msg.sender, msg.value, msg.data);
  }
}

