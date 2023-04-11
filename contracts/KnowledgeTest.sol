//SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.5.0 <0.9.0;

contract KnowledgeTest {
    string[] public tokens = ["BTC", "ETH"];
    address[] public players;
    address public owner;

    constructor() {
        owner = msg.sender;
    }

    function changeTokens() public {
        string[] storage t = tokens;
        t[0] = "VET";
    }

    receive() external payable {}

    function getBalance() public view returns (uint) {
        return address(this).balance;
    }

    function transferAll(address payable to) external {
        require(msg.sender == owner, "ONLY_OWNER");
        if (getBalance() <= 0) {
            return;
        }
        (bool result, ) = to.call{value: getBalance()}("");
        require(result, "TX_FAILED");
    }

    function start() public {
        players.push(msg.sender);
    }

    function concatenate(
        string calldata str1,
        string calldata str2
    ) public pure returns (string memory) {
        return string(abi.encodePacked(str1, str2));
    }
}
