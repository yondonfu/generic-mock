const functionSelector = funcSig => {
    return "0x" + Buffer.from(web3.sha3(funcSig).slice(2), "hex").slice(0, 4).toString("hex")
}

module.exports = {
    functionSelector
}
