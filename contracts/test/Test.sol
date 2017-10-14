pragma solidity ^0.4.13;

import "./IFoo.sol";


contract Test {
    IFoo myFoo;

    uint256 public value;
    uint256 public protectedValue;

    modifier onlyFoo() {
        require(msg.sender == address(myFoo));
        _;
    }

    function Test(address _foo) {
        myFoo = IFoo(_foo);
    }

    function getValue() public returns (uint256) {
        value = myFoo.foo();
    }

    function protectedFunc() public onlyFoo returns (bool) {
        protectedValue = 5;
        return true;
    }
}
