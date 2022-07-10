// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract FallbackExample{
    uint256 public result;
    /*
    아무런 데이터가 전달되지 않을 때, 다시말해 순수하게 eth의 주고 받음만 수행됐을 때는 receive,
    eth와 함께 contract의 함수를 호출하고자 하는 요청이 왔는데 해당 함수가 없을 때는 fallback 을 사용한다.
    */
    // Fallback 함수는 반드시 external로 선언되어야 한다.
    fallback() external payable{
        result += 1;
    }


    //solidity는 receive가 특별한 함수임을 알고 있기에 funciton과 같은 키워드를 붙여줄 필요가 없다.
    receive() external payable{
        result += 2;
    }
}