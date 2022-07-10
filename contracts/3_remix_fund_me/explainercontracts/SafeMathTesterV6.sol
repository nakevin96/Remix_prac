// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

contract SafeMathTester{
    // unchecked라는 것은 최대 수를 초과하면 가장 작은 수로 돌아감을 의미한다.
    // 즉 255가 저장된 상태에서 add()함수를 호출해 bigNumber에 1이 더해지면 0이된다는 뜻이다.
    uint8 public bigNumber = 255; // unchecked

    function add() public{
        bigNumber = bigNumber + 1;
    }
}