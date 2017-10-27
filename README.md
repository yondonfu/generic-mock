# Generic Mock

Solidity contract that can be used to mock contract dependencies during testing. Currently supports mocking the following
Solidity types: `uint256`, `bytes32`, `bool`

# Usage

When writing tests for a contract function that depends on values returned from a dependency contract:

```
it("test", async () => {
    const mock = await GenericMock.new()
    // Use the mock's address as the address of the dependency contract for the contract under test
    // This will vary depending on how the dependency injection takes place, but the address might be set
    // in the constructor of the contract under test

    // Set mock return value
    await mock.setMockUint256(functionSelector("foo()"), 5)
})
```

When writing tests for a contract function that can only be called by a whitelisted address:

```
it("test", async () => {
    const mock = await GenericMock.new()
    // Use the mock's address as the address of the dependency contract for the contract under test
    // This will vary depending on how the dependency injection takes place, but the address might be set
    // in the constructor of the contract under test

    await mock.execute(contractUnderTest.address, functionSelector("bar()"))
})
```

See `test/GenericMock.js` for an example.
