// SPDX-License-Identifier: MIT
pragma solidity >0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

//Errors


contract SimpleCardNFTFactory is ERC721 {
    uint public tokenId; //처음 선언할 때 tokenId=0
    mapping(address  => SimpleCardInfo ) private _infos; //issuer가 발급한 명함 정보
    mapping(address => uint[]) private _tokenIdsMadeByIssuer;  //issuer가 발급한 명함의 tokenId들
    mapping(address => mapping(uint=> bool)) _isTokenStillMine; //issuer가 발급한 tokenId들이 현재 issuer에게 있는지. 있으면 true, 없으면 false
    mapping(uint => address) private _issuerOfToken; //tokenId의 issuer
    mapping(address => uint) private _amountOfMySimpleCard; //issuer가 현재 가지고 있는 자신의 명함 개수(발급한 양 - 남들에게 transfer한 양)
    constructor() ERC721("SimpleCardNFT", "SCard") {}
    

    struct SimpleCardInfo { //내 명함에 들어가는 기본적인 정보들로 구조체(여러 개의 변수를 하나의 단위로 묶어서 관리할 수 있게 해주는 데이터 타입)를 만듦
        //essential
        string name;
        string email;
        address issuer; //발급한 사람. 즉 명함 정보의 주인
        
        //optional
        string company;
        string university;
        string major;
        string phone;
        string portfolio;
    }

    function registerSimpleCardInfo (string memory _name, //자신의 명함 NFT 정보 작성
        string memory _email,
        string memory _company,
        string memory _university,
        string memory _major,
        string memory _phone,
        string memory _portfolio
    )public{
        SimpleCardInfo memory simpleCardInfo = SimpleCardInfo({
            name:_name,
            email:_email,
            issuer: msg.sender,
            company:_company,
            university:_university,
            major:_major,
            phone:_phone,
            portfolio:_portfolio
        });
        _infos[msg.sender] = simpleCardInfo;
    } 

    function mintSimpleCardNFT () public payable{ //자신의 명함 NFT 한 개 발급
        SimpleCardInfo memory mySimpleCardInfo = _infos[msg.sender];
        require(
            keccak256(abi.encodePacked(mySimpleCardInfo.name)) != keccak256(abi.encodePacked("")),
            "Register your Simple Card info First"
        );
        tokenId++;
        
        _mint(msg.sender, tokenId);
    }

    function transferSimpleCardNFT () public {
        

    }



    




    // function createCard(string memory metadataURI) public  returns (uint256) {
    //     _tokenIds.increment();
    //     uint256 tokenId = _tokenIds.current();

    //     _mint(msg.sender, tokenId);

    //     return tokenId;
    // }

    // function updateMetadata(uint256 tokenId, string memory newMetadataURI) public  {
    //     _setTokenURI(tokenId, newMetadataURI);
    // }
}
