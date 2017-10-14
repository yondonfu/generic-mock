pragma solidity ^0.4.13;


/*
 * @title A mock contract that can set/return mock values and execute functions
 * on target contracts
 */
contract GenericMock {
    // Track function selectors and mapped mock values
    mapping (bytes4 => uint256) mockValues;

    /*
     * @dev Call a function on a target address using provided calldata for a function
     */
    function execute(address _target, bytes _data) external returns (bool) {
        return _target.call(_data);
    }

    /*
     * @dev Set a mock value for a function
     * @param _func Function selector (bytes4(keccak256(FUNCTION_SIGNATURE)))
     * @param _value Mock value
     */
    function setMockValue(bytes4 _func, uint256 _value) external returns (bool) {
        mockValues[_func] = _value;
    }

    function setMockValue

    /*
     * @dev Return mock value for a function
     */
    function() public {
        bytes4 func;
        assembly { func := calldataload(0) }

        uint32 size = 32;
        uint256 returnValue = mockValues[func];

        assembly {
            let memOffset := mload(0x40)
            mstore(0x40, add(memOffset, size))
            mstore(memOffset, returnValue)
            return(memOffset, size)
        }
    }
}
