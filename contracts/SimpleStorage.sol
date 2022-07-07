// SPDX-License-Identifier: MIT
pragma solidity ^0.8.8;

//solidity의 contract keyword는 java, javascript의 class와 유사하다.
contract SimpleStorage{
    /*solidity의 기본적인 자료형은 boolean, uint, int, address, bytes등이 있다.*/
    /*
    bool hasFavoriteNumber = true;
    uint256 favoriteNumber = 5;
    string favoriteNumber = "Five";
    int256 favoriteInt = -5;
    address myAddress = 0xdD36f70E96D6eC14ea69056238E777546F353D21;
    bytes32 favoriteBytes = "cat";
    */

    //This gets initialized to zero
    uint256 favoriteNumber;

    function store(uint256 _favoriteNumber) public{
        favoriteNumber = _favoriteNumber;
    }
}

//0xd9145CCE52D386f254917e481eB44e9943F39138