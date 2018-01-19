pragma solidity ^0.4.17;

import "./IFoo.sol";


contract Test {
    IFoo myFoo;

    uint256 public uint256Value;
    bytes32 public bytes32Value;
    bool public boolValue;
    bool public unsetValue;
    uint256 public protectedValue;

    modifier onlyFoo() {
        require(msg.sender == address(myFoo));
        _;
    }

    function Test(address _foo) public {
        myFoo = IFoo(_foo);
    }

    function getUint256Value() public {
        uint256Value = myFoo.foo();
    }

    function getBytes32Value() public {
        bytes32Value = myFoo.bar();
    }

    function getBoolValue() public {
        boolValue = myFoo.buzz();
    }

    function getUnsetValue() public {
        unsetValue = myFoo.jar();
    }

    function protectedFunc() public onlyFoo {
        protectedValue = 5;
    }
}
