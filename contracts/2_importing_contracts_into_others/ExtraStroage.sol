// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "./SimpleStorage.sol";

contract ExtraStorage is SimpleStorage{
    /*
    만약 contract를 상속받아 사용하고 싶다면
    우리는 두 가지 키워드에 대해 알아야 한다.
    바로 override와 virtual이다.
    
    override를 하고자 하는 함수를 작성할 때는 override 키워드를 붙여주어야 한다.
    그리고 기존에 존재하는 함수는 override를 하기위해서 virtual 키워드를 가져야 한다.
    */
    function store(uint256 _favoriteNumber) public virtual override {
        favoriteNumber = _favoriteNumber + 5;
    }
}