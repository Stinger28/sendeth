// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract ETHHandler {
    
    // Events
    event ETHReceived(address indexed sender, uint amount);
    event ETHSent(address indexed to, uint amount);
    
    // Function to deposit ETH
    function deposit() public payable {
        require(msg.value > 0, "Must send some ETH");
        emit ETHReceived(msg.sender, msg.value);
    }
    
    // Function to send ETH to any address
    function sendETH(address payable _to, uint _amount) public {
        require(_to != address(0), "Invalid address");
        require(_amount > 0, "Amount must be greater than 0");
        require(address(this).balance >= _amount, "Insufficient balance");
        
        _to.transfer(_amount);
        emit ETHSent(_to, _amount);
    }
    
    // Helper function to check contract balance
    function getBalance() public view returns (uint) {
        return address(this).balance;
    }
    
    // Receive function to accept direct ETH transfers
    receive() external payable {
        emit ETHReceived(msg.sender, msg.value);
    }
}
