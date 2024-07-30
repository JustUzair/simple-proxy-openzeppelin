// SPDX-License-Identifier: MIT
pragma solidity 0.8.25;

import {Script} from "forge-std/Script.sol";
import {console2} from "forge-std/console2.sol";
import {SmallProxy} from "../src/SmallProxy.sol";
import {ImplementationA} from "../src/ImplementationA.sol";
import {ImplementationB} from "../src/ImplementationB.sol";
import {HelperConfig} from "./HelperConfig.s.sol";

contract DeployAndSetImplementation is Script {
    address implementationA;
    address implementationB;
    SmallProxy proxy;

    function run() public {
        HelperConfig helperConfig = new HelperConfig();

        (uint256 deployerKey) = helperConfig.activeNetworkConfig();
        vm.startBroadcast(deployerKey);
        implementationA = address(new ImplementationA());
        implementationB = address(new ImplementationB());
        proxy = new SmallProxy();
        console2.log("===== Proxy Address : ", address(proxy), " ======");
        console2.log("===== Setting Implementation A =====");
        proxy.setImplementation(implementationA);
        console2.log("===== New Implementation Address (A): ", implementationA, " ======");
        uint256 newValueToSet = 10;
        bytes memory data = proxy.getDataToTransact(newValueToSet);
        (bool success,) = address(proxy).call(data);
        require(success, "Call to proxy failed");
        uint256 valueAfterCallingA = proxy.readStorage();
        console2.log("Value After calling set function in implementation A : ", valueAfterCallingA);

        console2.log("===== Setting Implementation B =====");
        proxy.setImplementation(implementationB);
        console2.log("===== New Implementation Address (B): ", implementationB, " ======");
        data = proxy.getDataToTransact(newValueToSet);
        (success,) = address(proxy).call(data);
        require(success, "Call to proxy failed");
        uint256 valueAfterCallingB = proxy.readStorage();
        console2.log("Value After calling set function in implementation B : ", valueAfterCallingB);
        vm.stopBroadcast();
    }
}
