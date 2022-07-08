// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;
/*
import문을 사용하면 다른 contract를 사용할 수 있게 된다.
주의해야 할 점은 solidity version이 호환가능해야 한다는 점이다.
*/
import "./SimpleStorage.sol";

contract StorageFactory{
    SimpleStorage[] public simpleStorageArray;

    function createSimpleStorageContract() public {
        SimpleStorage simpleStorage = new SimpleStorage();
        simpleStorageArray.push(simpleStorage);
    }
    function sfStore(uint256 _simpleStorageIndex, uint256 _simpleStorageNumber) public{
        /*
        어떤 contract와 상호작용(interact)하기 위해서는
        Contract의 address와 ABI가 필요하다.

        ABI는 Application Binary Interface의 약자로,
        ABI는 어떻게 해당 contract와 상호작용을 할 수 있는지에 관한 정보가 담겨있다.
        Contract를 통해 할 수 있는 모든 작업에 대한 input과 output에 대한 정보를 알려준다.
        */
        //SimpleStorage(address(simpleStorageArray[_simpleStorageIndex])).store(_simpleStorageNumber);
        simpleStorageArray[_simpleStorageIndex].store(_simpleStorageNumber);
    }
    function sfGet(uint256 _simpleStorageIndex) public view returns(uint256){
        //return SimpleStorage(address[simpleStorageArray[_simpleStorageIndex])).retrieve();
        return simpleStorageArray[_simpleStorageIndex].retrieve();
    }
}