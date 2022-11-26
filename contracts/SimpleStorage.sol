// SPDX-License-Identifier: MIT
pragma solidity 0.8.8;

contract SimpleStorage {
    // boolean, uint, int, address, bytes

    // This get initialized to zero!
    uint256 public favoriteNumber;
    People public person = People({favoriteNumber: 2, name: "Patric"});

    struct People {
        uint256 favoriteNumber;
        string name;
        
    }

    function store(uint256 _favoriteNumber) public {
        favoriteNumber = _favoriteNumber;
        favoriteNumber = favoriteNumber + 1;
    }
}

// 0xd9145CCE52D386f254917e481eB44e9943F39138
    

