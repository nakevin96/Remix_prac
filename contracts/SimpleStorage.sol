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
    // 변수의 기본 visibility는 internal이다.
    uint256 favoriteNumber;

    function store(uint256 _favoriteNumber) public{
        favoriteNumber = _favoriteNumber;
    }

    // ☆☆☆☆'gas'는 오직 blockchain의 state를 변경하는 transaction에 한해서만 소모된다.☆☆☆☆
    // view라는 것은 contract에 있는 function 밖이 정보를 읽기만 하는 작업이라 gas가 소모되지 않는다.
    // 이 view가 선언된 부분에서는 function밖의 정보를 수정할 수 없다.
    // 만약 pure라고 선언된다면, 이 함수 내에서는 함수 외부 값을 읽을수도, 변경할 수도 없다.
    // 아래의 경우 favoriteNumber에 아예 접근도 불가능 하다는 의미이다.
    function retrieve() public view returns(uint256){
        return favoriteNumber;
    }
}

//0xd9145CCE52D386f254917e481eB44e9943F39138