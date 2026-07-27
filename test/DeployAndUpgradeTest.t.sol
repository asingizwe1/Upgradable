// SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;

import {DeployBox} from "../script/DeployBox.s.sol";
import {UpgradeBox} from "../script/UpgradeBox.s.sol";
import {Test} from "forge-std/Test.sol";
import {StdCheats} from "forge-std/StdCheats.sol";
import {BoxV1} from "../src/BoxV1.sol";
import {BoxV2} from "../src/BoxV2.sol";

contract DeployAndUpgradeTest is StdCheats, Test {
    DeployBox public deployBox;
    UpgradeBox public upgradeBox;
    address public OWNER = address(1);

    function setUp() public {
        deployBox = new DeployBox();
        upgradeBox = new UpgradeBox();
    }

    function testBoxWorks() public {
        address proxyAddress = deployBox.deployBox();
        uint256 expectedValue = 1;
        assertEq(expectedValue, BoxV1(proxyAddress).version());
    }

    function testDeploymentIsV1() public {
        address proxyAddress = deployBox.deployBox();
        uint256 expectedValue = 7;
        vm.expectRevert();
        BoxV2(proxyAddress).setValue(expectedValue);
    }

    function testUpgradeWorks() public {
        address proxyAddress = deployBox.deployBox();//deploys V1 and a box pointing to it

        BoxV2 box2 = new BoxV2();//deploy a fresh box v2

        vm.prank(BoxV1(proxyAddress).owner());
        //a way to attach an interface (BoxV1) to an existing address (proxyAddress).
        BoxV1(proxyAddress)//treat the contract that already exists at proxyAddress as if it were a BoxV1.”
        .transferOwnership(msg.sender);

        address proxy = upgradeBox.upgradeBox(proxyAddress, address(box2));
//upgrade bos get proxy and point it to V2
        uint256 expectedValue = 2;
        assertEq(expectedValue, BoxV2(proxy).version());

        BoxV2(proxy).setValue(expectedValue);
        assertEq(expectedValue, BoxV2(proxy).getValue());
    }
}