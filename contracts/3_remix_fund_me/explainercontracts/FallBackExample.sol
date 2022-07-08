// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract FallbackExample{
    uint256 public result;

    // Fallback 함수는 반드시 external로 선언되어야 한다.
    fallback() external payable{
        result += 1;
    }

    receive() external payable{
        result += 2;
    }
}