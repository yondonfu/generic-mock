const GenericMock = artifacts.require("GenericMock")
const Test = artifacts.require("Test")

const functionSelector = funcSig => {
    return "0x" + Buffer.from(web3.sha3(funcSig).slice(2), "hex").slice(0, 4).toString("hex")
}

contract("GenericMock", accounts => {
    it("should return mock values", async () => {
        let mock = await GenericMock.new()
        let test = await Test.new(mock.address)

        const fooFunc = functionSelector("foo()")

        await mock.setMockValue(fooFunc, 5)
        await test.getValue()
        assert.equal(await test.value.call(), 5, "mock value incorrect")

        await mock.setMockValue(fooFunc, 8)
        await test.getValue()
        assert.equal(await test.value.call(), 8, "mock value incorrect")

        await mock.setMockValue(fooFunc, 15)
        await test.getValue()
        assert.equal(await test.value.call(), 15, "mock value incorrect")

    })

    it("should execute a permissioned function", async () => {
        let mock = await GenericMock.new()
        let test = await Test.new(mock.address)

        const protectedFunc = functionSelector("protectedFunc()")
        await mock.execute(test.address, protectedFunc)
        assert.equal(await test.protectedValue.call(), 5, "protected value not set by protected function")
    })
})
