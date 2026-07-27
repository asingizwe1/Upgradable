// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;
import {UUPSUpgradeable} from "@openzeppelin/contracts-upgradeable/proxy/utils/UUPSUpgradeable.sol";
import {OwnableUpgradeable} from "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";
import {Initializable} from "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";

//Initializable -> proxy doesnt use a constructor Initializer is more like the constructor
//  storage is stored in proxy and proxy will direct our calls to our implementation


//we call initialse through proxy not implementation
contract BoxV1 is Initializable, OwnableUpgradeable, UUPSUpgradeable {
    uint256 internal number;
    //UUPSUpgradeable could help add gaps and its by default 50 storage slots
        /// @custom:oz-upgrades-unsafe-allow constructor
    constructor() {//we cant use constructor in our proxy , constructor adds storage to implementation
        _disableInitializers();
    }

function getNumber() external returns (uint256){
return number;

}

    function initialize() public initializer {//this is constructor for proxies
        __Ownable_init();
        //double _ for initializable
        __UUPSUpgradeable_init();//shows that it is a UUPS contract
    }


function version() external returns (uint256){
return 1;

}

//below specifies who can upgrade
    function _authorizeUpgrade(address newImplementation) internal override onlyOwner {}
}
//proxies point to slot number instead of name od variables

/**When you upgrade from BoxV1 to BoxV2, you’re only swapping out the logic contract (the implementation).

The proxy keeps the same storage, so all your data (like number = 42) stays intact. */