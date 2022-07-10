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
    uint256 public minimumUsd = 50 * 10 ** 18;

    // fund를 제공해준 사용자를 저장할 변수를 선언
    address[] public funders;
    mapping(address => uint256) public addressToAmountFunded;

    address public owner;
    // constructor는 contract를 deploy했을 때 실행되는 함수이다.
    constructor(){
        // msg.sender는 deploy를 한 사람이 될 것이다.
        owner = msg.sender;
    }
    /*
    이더리움 플랫폼 위에서 이더 코인을 전송하는 스마트 컨트랙트를 작성하기 위해서는 반드시 payable키워드가 있어야 한다.
    즉 payable키워드가 들어간 function만이 이더를 주고 받을 수 있다는 의미이다.
    이 때 payable이 address와 함께 사용되면 지불 가능한 주소 : address payable이 되고
    function과 사용되면 지불가능한 함수 function payable이 된다.
    */
    function fund() public payable{
        /*
        이 부분에 이 contract에 funding을 받을 코드를 작성할 것이다.
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

    function withdraw() public onlyOwner {
        for(uint256 funderIndex=0; funderIndex < funders.length; funderIndex=funderIndex+1){
            address funder = funders[funderIndex];
            addressToAmountFunded[funder] = 0;
        }
        //reset the array
        funders = new address[](0);

        /* solidity-by-example.org/sending-ether/참조
        // transfer
        // msg.sender = address, payable(msg.sender) = payable address
        // 이더리움 전송 실패시 에러 발생 후 transaction revert
        payable(msg.sender).transfer(address(this).balance);

        //send
        // 거래가 실패하건 성공하건 boolean값만 반환하기 때문에 따로 revert처리 필요(require사용)
        bool sendSuccess = payable(msg.sender).send(address(this).balance);
        require(sendSuccess, "Send failed");

        //call
        (bool callSuccess, )=payable(msg.sender).call{value: address(this).balance}("");
        require(callSuccess, "Call failed");
        */
        (bool callSuccess, )=payable(msg.sender).call{value: address(this).balance}("");
        require(callSuccess, "Call failed");
    }

    /*
    modifer는 어떤 함수를 실행하기 전이나 후, 수행해야 하는 과정이 있을 때 사용할 수 있다.
    아래와 같이 onlyOwner를 만들고 withdraw를
    funciton withdraw() public onlyOwner{..}와 같이 선언하면
    require로 owner인지 아닌지 체크한 후 withdraw를 수행하는 것이다.
    전, 후는 _;로 확인하면 된다.
    */
    modifier onlyOwner {
        require(msg.sender == owner, "Sender is not owner!");
        _;

    }
    
}