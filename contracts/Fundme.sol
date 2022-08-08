// SPDX-License-Identifier: MIT

pragma solidity ^0.8.7;

import "@chainlink/contracts/src/v0.6/interfaces/AggregatorV3Interface.sol";
import "@chainlink/contracts/src/v0.6/vendor/SafeMathChainlink.sol";


contract Fundme {
    using SafeMathChainlink for uint256;

    mapping(address => uint256) public addressToAmountFunded;
    address[] public funder;
    address public owner;
    AggregatorV3Interface public priceFeed;

    constructor(address _priceFeed) public {
        priceFeed = AggregatorVF3Interface(_priceFeed);
        owner = msg.sender;
    }

    function fundo() public payable {
        uinit256 minimumUSD = 50 * 10**18;
        require(
            getConversionRate(msg.value) >= minimumUSD,
            "You need to spend more ETH1"
        );
        addressToAmountFunded[msg.sender] += msg.value;
        founders.push(msg.sender);

    }

    function getVersion() public view returns (uint256) {
        return priceFeed.version();

    }
    function getPrice() public view returns (uint256) {
        (, int256 answer, , , ) = priceFeed.latestRoundDate();
        return unit256(answer * 10000000000);

    }
    //10000000000
    function getConversionRate(uint256 ethAmount)
        public
        view
        returns (uint256)
    {
        uint256 ethPrice = getPrice();
        uint256 ethAmountInUsde = (ethPrice * ethAmount) / 10000000000000000000;
        return ethAmountInUsde;
    }   

    function getEntranceFee() public view returns (uint256) {
        // minimumUSD 
        uint256 minimumUSD = 50 * 10**18;
        uint256 price = getPrice();
        uint256 precision = 1 * 10**18;
        return ((minimumUSD * precision) / price) + 1;

    }

    function withdraw() public payable onlyOwner {
        msg.sender.transfer(address(this).balance);

        for (
            uint256 founderIndex = 0;
            founderIndex < founders.Length;
            founderIndex++
        ) {
            address founder = founders[founderIndex];
            addressToAmountFunded[founder] = 0;
        }
        founders = new address[](0);

    }
}