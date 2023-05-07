// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import "solmate/src/tokens/ERC721.sol";

enum Side {
    Buy,
    Sell
}
enum SignatureVersion {
    Single,
    Bulk
}

struct Fee {
    uint16 rate;
    address recipient;
}

struct Order {
    address trader;
    Side side;
    address matchingPolicy;
    address collection;
    uint256 tokenId;
    uint256 amount;
    address paymentToken;
    uint256 price;
    uint256 listingTime;
    uint256 expirationTime;
    Fee[] fees;
    uint256 salt;
    bytes extraParams;
}

struct Input {
    Order order;
    uint8 v;
    bytes32 r;
    bytes32 s;
    bytes extraSignature;
    SignatureVersion signatureVersion;
    uint256 blockNumber;
}

// ****   //

struct LienPointer {
    Lien lien;
    uint256 lienId;
}



struct Lien {                   // 抵押品
    address lender;             // 出借方 
    address borrower;           // 借款方
    ERC721 collection;          // 抵押品 合约地址
    uint256 tokenId;            // 抵押品 tokenId
    uint256 amount;             // 借款金额
    uint256 startTime;          // 开始时间
    uint256 rate;               // 利率
    uint256 auctionStartBlock;  // 拍卖开始区块
    uint256 auctionDuration;    // 拍卖持续时间
}

struct LoanOffer {                  // 借款方
    address lender;                 // 出借方
    ERC721 collection;              // 抵押品 合约地址
    uint256 totalAmount;            // 总金额
    uint256 minAmount;              // 最小金额
    uint256 maxAmount;              // 最大金额
    uint256 auctionDuration;        // 拍卖持续时间
    uint256 salt;                   // 随机数
    uint256 expirationTime;         // 过期时间
    uint256 rate;                   // 利率
    address oracle;                 // 预言机
}

struct LoanInput {
    LoanOffer offer;        // 借款方
    bytes signature;        // 签名
}


struct SellOffer {                  // 卖出 Offer , listing
    address borrower;               // 借款方
    uint256 lienId;                 // 抵押品 id , lienId 
    uint256 price;                  // 价格
    uint256 expirationTime;         // 过期时间
    uint256 salt;                   // 随机数
    address oracle;                 // 预言机
    Fee[] fees;                     // 手续费
}

struct SellInput {                  // 卖出 Input
    SellOffer offer;                // 卖出 Offer
    bytes signature;                // 签名
}

struct Execution {
    Input makerOrder;
    bytes extraSignature;
    uint256 blockNumber;
}
