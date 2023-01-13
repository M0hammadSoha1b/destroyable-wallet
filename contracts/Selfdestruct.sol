// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;
import"./Ownable.sol";

contract selfDestruct is Ownable {

    function Kill() external onlyOwner{
        selfdestruct(payable(msg.sender));
    }
}