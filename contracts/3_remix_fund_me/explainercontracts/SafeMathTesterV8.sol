// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SafeMathTester{
    /*
    버전 8부터는 unchecked로 'overflow'나 'underflow'가 발생했는지 아닌지 체크하여
    만약 발생하면 에러를 반환한다.
    */
    uint8 public bigNumber = 255; // checked

    function add() public{
        // 만약 overflow가 발생했을 때 에러를 발생시키는 것이 아닌 다시 0으로, 최소로 돌아가게 하고 싶다면 변수에 checked를 주석으로 붙이고
        // unchecked키워드로 묶어주면 된다.
        unchecked{bigNumber = bigNumber +1;}
    }
}