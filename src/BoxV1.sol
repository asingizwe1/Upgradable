// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;
import {UUPSUpgradeable} from "@openzeppelin/contracts-upgradeable/proxy/utils/UUPSUpgradeable.sol";

contract BoxV1 {
uint256 internal number;
function getNumber() external returns (uint256){
return number;

}
function version() external returns (uint256){
return 1;

}

}
