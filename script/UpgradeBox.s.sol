// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {Script} from "forge-std/Script.sol";
import {BoxV1} from "../src/BoxV1.sol";
import {BoxV2} from "../src/BoxV2.sol";
import {DevOpsTools} from "lib/foundry-devops/src/DevOpsTools.sol";

contract UpgradeBox is Script {
    function run() external returns (address) {//devopstools to help get from terminal
        address mostRecentlyDeployedProxy = DevOpsTools.get_most_recent_deployment("ERC1967Proxy", block.chainid);
//where we get the erc1971 proxy
        vm.startBroadcast();
        BoxV2 newBox = new BoxV2();
        vm.stopBroadcast();
        address proxy = upgradeBox(mostRecentlyDeployedProxy, address(newBox));
        return proxy;
    }
//we cant call upgrade on address but using abi
    function upgradeBox(address proxyAddress, address newBox) public returns (address) {
        vm.startBroadcast();
        //now that we have give proxy address the box v1 abi
        BoxV1 proxy = BoxV1(payable(proxyAddress));
        proxy.upgradeTo(address(newBox));//it says point the proxy to this new place
        vm.stopBroadcast();
        return address(proxy);
    }
}