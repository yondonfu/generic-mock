const { functionSelector } = require("../util/functionSelector")

const GenericMock = artifacts.require("GenericMock")
const Test = artifacts.require("Test")

contract("GenericMock", accounts => {
    let mock
    let test

    beforeEach(async () => {
        mock = await GenericMock.new()
        test = await Test.new(mock.address)
    })

    it("should return mock uint256 values", async () => {
        const fooFunc = functionSelector("foo()")

        await mock.setMockUint256(fooFunc, 5)
        await test.getUint256Value()
        assert.equal(await test.uint256Value.call(), 5, "mock value incorrect")

        await mock.setMockUint256(fooFunc, 8)
        await test.getUint256Value()
        assert.equal(await test.uint256Value.call(), 8, "mock value incorrect")
    })

    it("should return mock bytes32 values", async () => {
        const barFunc = functionSelector("bar()")
        const h1 = web3.sha3("hello")
        const h2 = web3.sha3("world")

        await mock.setMockBytes32(barFunc, h1)
        await test.getBytes32Value()
        assert.equal(await test.bytes32Value.call(), h1, "mock bytes32 value incorrect")

        await mock.setMockBytes32(barFunc, h2)
        await test.getBytes32Value()
        assert.equal(await test.bytes32Value.call(), h2, "mock bytes32 value incorrect")
    })

    it("should return mock bool values", async () => {
        const buzzFunc = functionSelector("buzz()")

        await mock.setMockBool(buzzFunc, true)
        await test.getBoolValue()
        assert.equal(await test.boolValue.call(), true, "mock bool value incorrect")

        await mock.setMockBool(buzzFunc, false)
        await test.getBoolValue()
        assert.equal(await test.boolValue.call(), false, "mock bool value incorrect")
    })

    it("should return false for a function signature that does not have a mock value set", async () => {
        await test.getUnsetValue()
        assert.equal(await test.unsetValue.call(), false, "unset value is not false")
    })

    it("should execute a permissioned function", async () => {
        const protectedFunc = functionSelector("protectedFunc()")
        await mock.execute(test.address, protectedFunc)
        assert.equal(await test.protectedValue.call(), 5, "protected value not set by protected function")
    })
})
