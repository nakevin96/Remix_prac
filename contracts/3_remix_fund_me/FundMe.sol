// SPDX-License-Identifier: MIT
pragma solidity ^0.8.8;

/*
이 파일에서 할 작업은
contract사용자들로 부터 fund를 받고
fund를 취소할 수 있는 기능을 만들고
USD기준으로 최소 funding value를 지정할 것이다.
*/
import './PriceConverter.sol';

contract FundMe {
    using PriceConverter for uint256;
    uint256 public minimumUsd = 50 * 1e18;

    // fund를 제공해준 사용자를 저장할 변수를 선언
    address[] public funders;
    mapping(address => uint256) public addressToAmountFunded;
    /*
    이더리움 플랫폼 위에서 이더 코인을 전송하는 스마트 컨트랙트를 작성하기 위해서는 반드시 payable키워드가 있어야 한다.
    즉 payable키워드가 들어간 function만이 이더를 주고 받을 수 있다는 의미이다.
    이 때 payable이 address와 함께 사용되면 지불 가능한 주소 : address payable이 되고
    function과 사용되면 지불가능한 함수 function payable이 된다.
    */
    function fund() public payable{
        /*
        이 부분에 funding을 받을 코드를 작성할 것이다.
        이 때 우리는 어떻게 ETH을 이 contract에서 받을 것인지 생각해봐야 한다.
        Transaction이 발생할 때 transaction은 다음과 같은 field를 갖는다.
        - Nonce: 계정의 transaction count
        - Gas Price: unit of gas의 가격을 의미하며 단위는 wei이다.
        - Gas Limit: transaction이 사용할 수 있는 최대 가스 값을 뜻한다.
        - To: transaction이 발생했을 때 value를 받는 주소
        - Value: 얼마만큼 보낼 것인지, 단위는 wei
        - Data: To address에 어떤 걸 보내는지
        - v, r, s: transaction signatur의 구성요소
        */
        // 1e18은 1 * 10 ** 18과 같다. 1*10**18 wei 가 1 eth이기 때문에 require과 합쳐
        // 1eth이상을 제한으로 걸 수 있다.
        // require는 체크 함수로 앞에서 조건을 체크하고 만약 만족하지 않는다면 두번째 인자를 바탕으로 에러를 반환한다.
        //require(msg.value >= 1e18, "Didn't send enough!");
        //require(msg.value >= minimumUsd, "Didn't send enough!");
        require(msg.value.getConversionRate() >= minimumUsd, "Didn't send enough!");
        funders.push(msg.sender);
        addressToAmountFunded[msg.sender] = msg.value;
    }

    function withdraw() public {
        for(uint256 funderIndex=0; funderIndex < funders.length; funderIndex=funderIndex+1){
            address funder = funders[funderIndex];
            addressToAmountFunded[funder] = 0;
        }
        
    }
    
}