// SPDX-License-Identifier: MIT
pragma solidity ^0.8.27;
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Votes.sol";
import "@openzeppelin/contracts/utils/cryptography/EIP712.sol";
import "@openzeppelin/contracts/access/Ownable2Step.sol";

contract HaloToken is ERC20Votes, Ownable2Step {
    uint256 private constant initialSupply = 2_100_000_000e18; // 2.1billion

    constructor(
        string memory name_,
        string memory symbol_,
        address receiver_,
        address owner_
    ) ERC20(name_, symbol_) EIP712(name_, "1.0.0") Ownable(owner_) {
        _mint(receiver_, initialSupply);
    }

    function mint(address to, uint256 amount) external onlyOwner {
        _mint(to, amount);
    }

    function burn(uint256 value) external {
        _burn(msg.sender, value);
    }

    function burnFrom(address account, uint256 value) external {
        _spendAllowance(account, _msgSender(), value);
        _burn(account, value);
    }
}
