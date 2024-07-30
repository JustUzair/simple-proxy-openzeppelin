// SPDX-License-Identifier: MIT
pragma solidity 0.8.25;

import {Test} from "forge-std/Test.sol";
import {console2} from "forge-std/console2.sol";
import {SmallProxy} from "../src/SmallProxy.sol";
import {ImplementationA} from "../src/ImplementationA.sol";
import {ImplementationB} from "../src/ImplementationB.sol";

contract TextProxy is Test {
    address implementationA;
    address implementationB;
    SmallProxy proxy;
    address user = makeAddr("user");

    function setUp() public {
        vm.startBroadcast(user);
        implementationA = address(new ImplementationA());
        implementationB = address(new ImplementationB());
        proxy = new SmallProxy();
        vm.stopBroadcast();
    }

    function test_proxyWithImplementationA() public {
        vm.startBroadcast(user);
        proxy.setImplementation(implementationA);
        uint256 newValueToSet = 10;
        bytes memory data = proxy.getDataToTransact(newValueToSet);
        (bool success,) = address(proxy).call(data);
        require(success, "Call to proxy failed");
        uint256 valueAfterCallingA = proxy.readStorage();
        console2.log("Value After calling set function in implementation A : ", valueAfterCallingA);
        assertEq(valueAfterCallingA, newValueToSet);
    }

    function test_proxyWithImplementationB() public {
        vm.startBroadcast(user);
        proxy.setImplementation(implementationB);
        uint256 newValueToSet = 10;
        bytes memory data = proxy.getDataToTransact(newValueToSet);
        (bool success,) = address(proxy).call(data);
        require(success, "Call to proxy failed");
        uint256 valueAfterCallingA = proxy.readStorage();
        console2.log("Value After calling set function in implementation A : ", valueAfterCallingA);
        // adding 10 because implementation B adds 10 to the value
        assertEq(valueAfterCallingA, newValueToSet + 10);
    }
}
