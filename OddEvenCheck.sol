pragma solidity ^0.6.0;

contract OddEvenCheck {

    uint[] numberArray = [1,2,3,4,5,6,7,8,9,10];
    address owner;

    function countEvensInArray() public view returns (uint) {
        uint count = 0;

        for (uint i = 0; i < numberArray.length; i++) {
            if (isEvenOrOdd(numberArray[i])) {
                count ++;
            }
        }

        return count;
    }

    function countOddsInArray() public view returns (uint) {
        uint count = 0;

        for (uint i = 0; i < numberArray.length; i++) {
            if (!isEvenOrOdd(numberArray[i])) {
                count ++;
            }
        }

        return count;
    }

    function isEvenOrOdd(uint _value) public pure returns (bool) {
        return (_value % 2 == 0);
    }
}