# Deployments & Addresses

## Deploy using script

```bash
forge script script/DeployAndSetImplementation.s.sol --rpc-url polygon_amoy --verify
```

### Network : Polygon Amoy

- `SmallProxy.sol` : [0xa7f5d9abb077b618b3d1f7924c9584e1f4124af6](https://amoy.polygonscan.com/address/0xa7f5d9abb077b618b3d1f7924c9584e1f4124af6)
- `ImplementationA.sol` : [0xd60ea9663A9D546faEfbd1dDc15072120a44c9ef](https://amoy.polygonscan.com/address/0xd60ea9663A9D546faEfbd1dDc15072120a44c9ef)
- `ImplementationB.sol` : [0x6CDb8366B2909a516B7aA2F8501514309900e82E](https://amoy.polygonscan.com/address/0x6CDb8366B2909a516B7aA2F8501514309900e82E)

## Foundry

**Foundry is a blazing fast, portable and modular toolkit for Ethereum application development written in Rust.**

Foundry consists of:

- **Forge**: Ethereum testing framework (like Truffle, Hardhat and DappTools).
- **Cast**: Swiss army knife for interacting with EVM smart contracts, sending transactions and getting chain data.
- **Anvil**: Local Ethereum node, akin to Ganache, Hardhat Network.
- **Chisel**: Fast, utilitarian, and verbose solidity REPL.

## Documentation

https://book.getfoundry.sh/

## Usage

### Build

```shell
$ forge build
```

### Test

```shell
$ forge test
```

### Format

```shell
$ forge fmt
```

### Gas Snapshots

```shell
$ forge snapshot
```

### Anvil

```shell
$ anvil
```

### Deploy

```shell
$ forge script script/Counter.s.sol:CounterScript --rpc-url <your_rpc_url> --private-key <your_private_key>
```

### Cast

```shell
$ cast <subcommand>
```

### Help

```shell
$ forge --help
$ anvil --help
$ cast --help
```
