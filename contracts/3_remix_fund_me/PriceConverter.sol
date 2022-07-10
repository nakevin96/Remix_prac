// SPDX-License-Identifier: MIT

/*
Library라는 것은 contract와 유사하다.
다만 차이점은 state 변수를 선언하거나 ethereum을 전송하는 것을 할 수 없다는 것 뿐이다.
*/
pragma solidity ^0.8.8;

// ABI 정보
import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

library PriceConverter{
    /*
    getPrice function은 ethereum의 가격을 USD가격으로 받아오기 위한 함수이다.
    Block chain에서 이루어지는 transaction은 신뢰를 할 수 있지만 외부 작업에 대한 신뢰성은 보장할 수 없다는
    oracle problem이 있는데 이를 해결해주는게 chain link라고 하는 third-party이다.
    */
    function getPrice() internal view returns(uint256){
        //ABI
        //Address 0x8A753747A1Fa494EC906cE90E9f37563A8AF630e
        AggregatorV3Interface priceFeed = AggregatorV3Interface(0x8A753747A1Fa494EC906cE90E9f37563A8AF630e);
        //(uint80 roundId, int price, uint startedAt, uint timeStamp, uint80 answeredInRound)= priceFeed.latestRoundData();
        (, int256 price,,,) = priceFeed.latestRoundData();
        return uint256(price * 1e10);
    }

    function getConversionRate(uint256 ethAmount) internal view returns (uint256){
        uint256 ethPrice = getPrice();
        uint256 ethAmountInUsd = (ethPrice * ethAmount) / 1e18;
        return ethAmountInUsd;
    }

    //function withdraw(){}
}