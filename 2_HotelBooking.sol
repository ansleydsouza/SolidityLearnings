// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.6.0;

/**
*   @title Hotel Booking
*   @dev Implements a Hotel Room Booking contract
*/
contract HotelBooking {

    //Enum to keep track of the Booking status
    enum Statuses { Vacant, Occupied }

    //Variable to hold the current status from the enum
    Statuses currentStatus;

    //Event for occupy by person
    event Occupy(address _occupant, uint _value);

    //Address variable to keep track of who deployed the contract
    address payable public owner;

    //Constructor
    constructor() public {
        owner = msg.sender;
        currentStatus = Statuses.Vacant;
    }

    //Modifier to allow booking when vacant
    modifier onlyWhileVacant {
        require (currentStatus == Statuses.Vacant, "Currently Occupied");
        _;
    }

    //Modifier to check the amout of ether transferred to the contract
    modifier costs (uint _amount) {
        require (msg.value >= _amount, "Not enough ether paid");
        _;
    }

    //Modifier to check if the room is currently occupied
    modifier onlyWhileOccupied {
        require (currentStatus == Statuses.Occupied, "Currently Vacant");
        _;
    }

    //receive function
    receive() payable external onlyWhileVacant costs(2 ether) {
        currentStatus = Statuses.Occupied;
        owner.transfer(msg.value);
        emit Occupy(msg.sender, msg.value); //This can be consumed externally
    }

    //Release room function
    function releaseRoom() external onlyWhileOccupied{
        currentStatus = Statuses.Vacant;
        emit Occupy(owner,0);
    }

}