pragma solidity ^0.4.13;

import "./IFoo.sol";


contract Test {
    IFoo myFoo;

    uint256 public uint256Value;
    bytes32 public bytes32Value;
    uint256 public protectedValue;

    modifier onlyFoo() {
        require(msg.sender == address(myFoo));
        _;
    }

    function Test(address _foo) {
        myFoo = IFoo(_foo);
    }

    function getUint256Value() public returns (uint256) {
        uint256Value = myFoo.foo();
    }

    function getBytes32Value() public returns (bytes32) {
        bytes32Value = myFoo.bar();
    }

    function protectedFunc() public onlyFoo returns (bool) {
        protectedValue = 5;
        return true;
    }
}
