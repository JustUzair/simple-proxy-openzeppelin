// SPDX-License-Identifier: MIT
pragma solidity 0.8.25;

import {Proxy} from "@openzeppelin/contracts/proxy/Proxy.sol";

contract SmallProxy is Proxy {
    // implementation slot location = keccak256("eip1967.proxy.implementation") - 1
    // chisel ---> kecccak256("eip1967.proxy.implementation") = 0x360894a13ba1a3210667c828492db98dca3e2076cc3735a920a3ca505d382bbd
    bytes32 private constant _IMPLEMENTATION_SLOT = 0x360894a13ba1a3210667c828492db98dca3e2076cc3735a920a3ca505d382bbc;

    function setImplementation(address implementationAddress) external {
        assembly {
            sstore(_IMPLEMENTATION_SLOT, implementationAddress)
        }
    }

    function _implementation() internal view override returns (address implementationAddress) {
        assembly {
            implementationAddress := sload(_IMPLEMENTATION_SLOT)
        }
    }

    // Helper functions
    function getDataToTransact(uint256 numberToUpdate) public pure returns (bytes memory) {
        return abi.encodeWithSignature("setValue(uint256)", numberToUpdate);
    }

    function readStorage() public view returns (uint256 valueAtStorageSlotZero) {
        assembly {
            valueAtStorageSlotZero := sload(0)
        }
    }

    receive() external payable {}

    fallback() external payable override {
        super._fallback();
    }
}
