//SPDX-LICENSE-Identifier: MIT
Pragma solidity ^0.8.4;


//INTERNL IMPORT FOR NFT OPENZIPPLINE
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";                      //for creating the NFT
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol"; //for storing the tokenURI
import "@openzeppelin/contracts/utils/Counters.sol";                           //for counting the number of NFTs

import "hardhat/console.sol";                                                  //for debugging

contract NFTMarketplace is ERC721URIStorage {
    using Counters for Counters.Counter; 
    Counters.Counter private _tokenIds;         //for counting the number of NFTs
    Counters.Counter private _itemsSold;        //for counting the number of items sold

    uint256 public listingPrice = 0.025 ether;  //for the listing price of the NFT

    address payable owner;                      //for the owner of the contract

   mapping(unit256 => MarketItem) private idMarketItem; //for mapping the NFTs to the market items

   struct MarketItem {
       uint256 itemId;              //for the id of the market item
       address nftContract;         //for the address of the NFT contract
       uint256 tokenId;             //for the id of the NFT
       address payable seller;      //for the address of the seller
       address payable owner;       //for the address of the owner
       uint256 price;               //for the price of the NFT
       bool sold;                   //for checking if the sNFT is sold or not
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
       owner = payable(msg.sender);   //for setting the owner of the contract
   }

    modifier onlyOwner() {
        require(msg.sender == owner, "You are not the owner of the contract");
        _;
    }
    // charging the seller for the listing fee
    function updateListingPrice(uint256 _listingPrice) payable public onlyOwner {
        listingPrice = _listingPrice;
    }

    //reading the listing price with public view

    function getListingPrice() public view returns (uint256) {
        return listingPrice;
    }

    //NFT Token Creation
    function createToken(string memory tokenURI, unit256 price)public payable return (unit256){
        _tokenIds.increment();                      //incrementing the token id
        unit256 newTokenId = _tokenIds.current();   //getting the current token id

        _mint(msg.sender, newTokenId);              //minting the NFT //mint function is from ERC721
        _setTokenURI(newTokenId, tokenURI);         //setting the tokenURI

        createMarketItem(newTokenId, price);   //creating the market item

        return newTokenId;
    }

    //creating the market item
    function createMarketItem(uint256 tokenId, uint256 price) public payable {
        require(price > 0, "Price must be greater than 0");
        require(msg.sender == ownerOf(tokenId), "You are not the owner of the token");

        _itemsSold.increment();                     //incrementing the items sold
        unit256 itemId = _itemsSold.current();       //getting the current item id

        idMarketItem[itemId] = MarketItem(
            itemId,
            address(this),
            tokenId,
            payable(msg.sender),
            payable(address(0)),
            price,
            false
        );

        emit idMarketItemCreated(
            itemId,
            msg.sender,
            address(0),
            price,
            false
        );
    }
    
}