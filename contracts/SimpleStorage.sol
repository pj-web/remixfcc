// SPDX-License-Identifier: MIT
pragma solidity 0.8.8;

// EVM, Ethereum Virtual Machine
// Avalanche, Fantom, Polygon

contract SimpleStorage {
    // boolean, uint, int, address, bytes

    // This get initialized to zero!
    uint256 public favoriteNumber;

    mapping(string => uint256) public nameToFavoriteNumber;

    People public person = People({favoriteNumber: 2, name: "Patric"});

    struct People {
        uint256 favoriteNumber;
        string name;   
    }

    People[] public people;

    function store(uint256 _favoriteNumber) public virtual {
        favoriteNumber = _favoriteNumber;
    }

    // view, pure
    function retrieve() public view returns(uint256) {
        return favoriteNumber;
    }

    // calldata, memory, storage
    function addPerson(string memory _name, uint256 _favoriteNumber) public {
        people.push(People(_favoriteNumber, _name));
        nameToFavoriteNumber[_name] = _favoriteNumber;
    }
}

// New editions

// 0xd9145CCE52D386f254917e481eB44e9943F39138
    

