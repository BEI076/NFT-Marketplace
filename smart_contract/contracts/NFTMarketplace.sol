//SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

//INTERNL IMPORT FOR NFT OPENZIPPLINE
import "@openzeppelin/contracts/token/ERC721/ERC721.sol"; //for creating the NFT
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol"; //for storing the tokenURI
import "@openzeppelin/contracts/utils/Counters.sol"; //for counting the number of NFTs

import "hardhat/console.sol"; //for debugging

contract NFTMarketplace is ERC721URIStorage {
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds; //for counting the number of NFTs
    Counters.Counter private _itemsSold; //for counting the number of items sold

    uint256 public listingPrice = 0.025 ether; //for the listing price of the NFT

    address payable owner; //for the owner of the contract

    mapping(uint256 => MarketItem) private idMarketItem; //for mapping the NFTs to the market items //try itMarkettoItem if error

    struct MarketItem {
        uint256 tokenId; //for the id of the NFT
        address payable seller; //for the address of the seller
        address payable owner; //for the address of the owner
        uint256 price; //for the price of the NFT
        bool sold; //for checking if the sNFT is sold or not
    }

    //for creating the NFT
    event idMarketItemCreated(
        uint256 indexed tokenId,
        address seller,
        address owner,
        uint256 price,
        bool sold
    );


    constructor() ERC721("NFT Metaverse Token", "MYNFT") {
        owner = payable(msg.sender); //for setting the owner of the contract
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "You are not the owner of the contract");
        _;
    }

    // Updates the listing price of the contract
    function updateListingPrice(
        uint256 _listingPrice
    ) public payable onlyOwner {
        require(
            owner == msg.sender,
            "Only marketplace owner can update listing price."
        );
        listingPrice = _listingPrice;
    }

    //reading the listing price with public view

    function getListingPrice() public view returns (uint256) {
        return listingPrice;
    }

    //NFT Token Creation
    function createToken(
        string memory tokenURI,
        uint256 price
    ) public payable returns (uint256) {
        _tokenIds.increment(); //incrementing the token id
        uint256 newTokenId = _tokenIds.current(); //getting the current token id

        _mint(msg.sender, newTokenId); //minting the NFT //mint function is from ERC721
        _setTokenURI(newTokenId, tokenURI); //setting the tokenURI

        createMarketItem(newTokenId, price); //creating the market item

        return newTokenId;
    }

    //creating the market item
    function createMarketItem(uint256 tokenId, uint256 price) private {
        require(price > 0, "Price must be greater than 0");
        require(
            msg.value == listingPrice,
            "Price must be equal to listing price"
        );
        require(
            msg.sender == ownerOf(tokenId),
            "You are not the owner of the token"
        ); //getting the current item id

        idMarketItem[tokenId] = MarketItem(
            tokenId,
            payable(msg.sender),
            payable(address(this)),
            price,
            false
        );

        _transfer(msg.sender, address(this), tokenId); //transferring the ownership of the NFT to the contract
        emit idMarketItemCreated(
            tokenId,
            msg.sender,
            address(this),
            price,
            false
        );
    }


    //function for resale of the NFT

    function reSellToken(uint256 tokenId, uint256 price) public payable {
        require(
            idMarketItem[tokenId].owner == msg.sender,
            "You are not the owner of the token"
        );
        require(
            msg.value == listingPrice,
            "Price must be equal to listing price"
        );

        idMarketItem[tokenId].price = price;
        idMarketItem[tokenId].sold = false;
        idMarketItem[tokenId].seller = payable(msg.sender);
        idMarketItem[tokenId].owner = payable(address(this));

        _itemsSold.decrement(); //decrementing the items sold
        _transfer(msg.sender, address(this), tokenId); //transferring the ownership of the NFT to the contract

    }


    //function createMarketSale
    //selling the NFT

    function createMarketSale(uint tokenId) public payable {
        uint256 price = idMarketItem[tokenId].price;
        require(
            msg.value == price,
            "Price must be equal to the price of the token. Please check the price of the token"
        );

        idMarketItem[tokenId].owner = payable(msg.sender); //setting the owner of the NFT
        idMarketItem[tokenId].sold = true; //setting the NFT as sold
        idMarketItem[tokenId].seller = payable(address(0)); //setting the seller of the NFT as 0x0

        _transfer(address(this), msg.sender, tokenId); //transferring the ownership of the NFT to the buyer
        payable(owner).transfer(listingPrice); //transferring the amount to the owner of the contract
        payable(idMarketItem[tokenId].seller).transfer(price); //transferring the amount to the seller of the NFT
    }

    //function for fetching the market items from the contract and are unsold
    function fetchMarketItems() public view returns (MarketItem[] memory) {
        uint256 itemCount = _tokenIds.current(); //getting the current item count
        uint256 unsoldItemCount = _tokenIds.current() - _itemsSold.current(); //getting the current unsold item count
        uint256 currentIndex = 0; //setting the current index to 0

        MarketItem[] memory items = new MarketItem[](unsoldItemCount); //creating a new array of market items with the unsold item count
        for (uint256 i = 0; i < itemCount; i++) {
            //for loop for iterating through the market items
            if (idMarketItem[i + 1].owner == address(this)) {
                //checking if the owner of the NFT is the contract
                uint256 currentId = idMarketItem[i + 1].tokenId;
                MarketItem storage currentItem = idMarketItem[currentId];
                items[currentIndex] = currentItem;
                currentIndex += 1;
            }
        }
        return items;
    }

    //unsold contracts items

    function fetchItemsListed() public view returns (MarketItem[] memory) {
        uint256 totalCount = _tokenIds.current(); //getting the current item count
        uint256 itemCount = 0; //setting the item count to 0
        uint256 currentIndex = 0; //setting the current index to 0

        // to know the number of items the user has
        for (uint256 i = 0; i < totalCount; i++) {
            //for loop for iterating through the market items
            if (idMarketItem[i + 1].seller == msg.sender) {
                itemCount += 1;
            }
        }

        //to get the items

        MarketItem[] memory items = new MarketItem[](itemCount); //creating a new array of market items with the unsold item count
        for (uint256 i = 0; i < totalCount; i++) {
            //for loop for iterating through the market items
            if (idMarketItem[i + 1].seller == msg.sender) {
                //checking if the owner of the NFT is the contract
                uint256 currentId = i + 1;
                MarketItem storage currentItem = idMarketItem[currentId];
                items[currentIndex] = currentItem; //setting the current item
                currentIndex += 1;
            }
        }
        return items;


    }


    function fetchMyNFT() public view returns (MarketItem[] memory items) {
        uint256 totalCount = _tokenIds.current();
        uint256 itemCount = 0;
        uint256 currentIndex = 0;

        // Count the number of items the user owns
        for (uint256 i = 0; i < totalCount; i++) {
            if (idMarketItem[i + 1].owner == msg.sender) {
                itemCount += 1;
            }
        }

        // Initialize the items array with the correct size
        items = new MarketItem[](itemCount);

        // Populate the items array with the user's NFTs
        for (uint256 i = 0; i < totalCount; i++) {
            if (idMarketItem[i + 1].owner == msg.sender) {
                uint256 currentId = i + 1;
                MarketItem storage currentItem = idMarketItem[currentId];
                items[currentIndex] = currentItem;
                currentIndex += 1;
            }

        }

        return items;
    }



}
