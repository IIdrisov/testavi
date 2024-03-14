// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Aviator{
    address public owner1;
    address public owner2;

    constructor() {
        owner1 = msg.sender;
        owner2 = address(0); 
    }
    
    modifier onlyOwner {
        require(msg.sender == owner1 || msg.sender == owner2, "You are not an owner");
        _;
    }

    function setSecondOwner(address _newOwner) public onlyOwner {
        require(_newOwner != address(0), "Invalid address");
        require(msg.sender == owner1 && owner2 == address(0), "Second owner already set");
        
        owner2 = _newOwner;
    }

    event PaymentReceived(address indexed sender, uint256 amount, uint256 timestamp);

    function receivePayment() external payable {
        emit PaymentReceived(msg.sender, msg.value, block.timestamp);
    }

    // function getPaymentInfo() internal view returns (address, uint256, uint256) {
    //     return (msg.sender, msg.value, block.timestamp);
    // }

    event PaymentSent (address indexed to, uint amount);

    function sendWinBet(address payable  _to, uint _amount) public  payable {
        emit PaymentSent(_to, _amount);
        _to.transfer(_amount);
    }

}

