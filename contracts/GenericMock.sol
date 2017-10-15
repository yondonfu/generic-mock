pragma solidity ^0.4.13;


/*
 * @title A mock contract that can set/return mock values and execute functions
 * on target contracts
 */
contract GenericMock {
    struct MockValue {
        uint256 uint256Value;
        bytes32 bytes32Value;
        MockValueType valueType;
    }

    enum MockValueType { Uint256, Bytes32, None }

    // Track function selectors and mapped mock values
    mapping (bytes4 => MockValue) mockValues;

    /*
     * @dev Call a function on a target address using provided calldata for a function
     * @param _target Target contract to call with data
     * @param _data Transaction data to be used to call the target contract
     */
    function execute(address _target, bytes _data) external returns (bool) {
        return _target.call(_data);
    }

    /*
     * @dev Set a mock uint256 value for a function
     * @param _func Function selector (bytes4(keccak256(FUNCTION_SIGNATURE)))
     * @param _value Mock value
     */
    function setMockValue(bytes4 _func, uint256 _value) external returns (bool) {
        mockValues[_func].valueType = MockValueType.Uint256;
        mockValues[_func].uint256Value = _value;
    }

    /*
     * @dev Set a mock bytes32 value for a function
     * @param _func Function
     * @param _func Function selector (bytes4(keccak256(FUNCTION_SIGNATURE)))
     * param _value Mock value
     */
    function setMockValue(bytes4 _func, bytes32 _value) external returns (bool) {
        mockValues[_func].valueType = MockValueType.Bytes32;
        mockValues[_func].bytes32Value = _value;
    }

    /*
     * @dev Return mock value for a functione
     */
    function() public {
        bytes4 func;
        assembly { func := calldataload(0) }

        if (mockValues[func].valueType == MockValueType.Uint256) {
            mLoadAndReturn(mockValues[func].uint256Value);
        } else if (mockValues[func].valueType == MockValueType.Bytes32) {
            mLoadAndReturn(mockValues[func].bytes32Value);
        } else {
            // No type set - no mock value
            revert();
        }
    }

    /*
     * @dev Load a uint256 value into memory and return it
     * @param _value Uint256 value
     */
    function mLoadAndReturn(uint256 _value) private {
        assembly {
            let memOffset := mload(0x40)
            mstore(0x40, add(memOffset, 32))
            mstore(memOffset, _value)
            return(memOffset, 32)
        }
    }

    /*
     * @dev Load a bytes32 value into memory and return it
     * @param _value Bytes32 value
     */
    function mLoadAndReturn(bytes32 _value) private {
        assembly {
            let memOffset := mload(0x40)
            mstore(0x40, add(memOffset, 32))
            mstore(memOffset, _value)
            return(memOffset, 32)
        }
    }
}
