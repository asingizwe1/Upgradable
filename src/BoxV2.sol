// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;
// forge install OpenZeppelin/openzeppelin-contracts-upgradable
//https://github.com/Cyfrin/foundry-upgrades-cu/blob/main/src/BoxV2.sol
import {OwnableUpgradeable} from "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";
import {Initializable} from "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";
import {UUPSUpgradeable} from "@openzeppelin/contracts-upgradeable/proxy/utils/UUPSUpgradeable.sol";

contract BoxV2 is Initializable, OwnableUpgradeable, UUPSUpgradeable {
uint256 internal number;
function getNumber() external returns (uint256){
return number;

}

function setNumber(uint256 _number) external returns (uint256){
number=_number;

}

function version() external returns (uint256){
return 2;

}

}
//deploy box 1 and upgrade its CA via box 2
//deploy our proxy to box V2