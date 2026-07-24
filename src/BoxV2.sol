// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;
// forge install OpenZeppelin/openzeppelin-contracts-upgradable
contract BoxV2 {
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