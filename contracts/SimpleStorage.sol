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
    People person = People({favoriteNumber: 2, name:"Yoon"});

    //uint256 public favoriteNumbersList;
    // solidity에서 array는 아래와 같이 선언했을 때 dynamic array이다. 
    People[] people;

    struct People{
        uint256 favoriteNumber;
        string name;
    }

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


    // memeory keyword는 무엇일까?
    /*
    solidity에서 데이터를 저장할 수 있는 공간은 총 6개가 있다.
    1. Stack
    2. Memory
    3. Storage
    4. Calldata
    5. Code
    6. Logs

    이 중에서 이 주석칸에서는 calldata, memory, storage에 대해서만 알아볼 것이다.
    calldata와 memory는 "변수가 일시적으로만 존재한다" 라는 것을 의미한다.
    즉 아래 _name변수 역시 addPerson이라는 함수가 실행이 되었을 때에 한해서
    일시적으로만 존재함을 뜻한다.
    그럼 calldata와 memory의 차이는 무엇일까?
    calldata 변수는 함수 내에서 수정이 일어나지 않음을 의미하며
    memory 변수는 함수 내에서 수정이 가능하다.
    아래 예시에서 _name의 경우 addPerson내에서 변형이 가능하다는 뜻이다.
    
    storage variable은 블록체인 상에 영구적으로 저장되는 변수를 말한다.

    여기서 한 가지 의문이 생길 수 있는데
    바로 왜 _name에는 memory를 붙여주고 _favoriteNumber에는 붙여주지 않았는가이다.
    이는 _favoriteNumber앞에 memory를 붙여 컴파일 해보면 알 수 있다.
    Data location은 array, struct, mapping type에만 사용할 수 있기 때문이다.
    uint256은 확실히 memory에 저장하면 된다는 것을 알지만
    string type의 경우 array of bytes이기 때문에 Data location을 명시해주어야 한다.
    */
    function addPerson(string memory _name, uint256 _favoriteNumber) public{
        // array에 값을 넣기 위해서는 push라는 함수를 사용한다.
        // People struct가 선언된 순서대로 변수를 넣어주면 아래와 같이 객체형태로 집어넣지 않아도 된다!
        // People memory newPerson = People(_favoriteNumber, _name);
        People memory newPerson = People({favoriteNumber: _favoriteNumber, name: _name});
        people.push(newPerson);
    }
}
