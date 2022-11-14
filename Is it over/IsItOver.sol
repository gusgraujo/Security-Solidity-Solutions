pragma solidity ^0.4.21;


contract IsItOver {
    bool public isComplete;
    uint256[] map;
    event Log(uint256[] map);
    function setKeyAndValue(uint256 key, uint256 value) public {
        // Expand dynamic array as needed
        if (map.length <= key)
            map.length = key + 1;

        map[key] = value;
        emit Log(map);
    }

    function getValue(uint256 key) public view returns (uint256) {
        return map[key];
    }
}