import React from "react";
import images from "../../img";
import Link from "next/link";
import Image from "next/image";

// internal import
import Style from "./Service.module.css";

const Service = () => {
  return (
    <div className={Style.service}>
      <div className={Style.service_box}>
        <div className={Style.service_box_item}>
          <Image
            src={images.service1}
            alt="Service and Discover"
            height={100}
            width={100}
          />
          <p className={Style.service_box_item_step}>
            <span>Step 1</span>
          </p>
          <h3>Filter and Discover </h3>
          <p>Connect Wallet, Discover, Buys NFTs, Sell NFTs and earn money</p>
        </div>
        <div className={Style.service_box_item}>
          <Image
            src={images.service2}
            alt="Connect Wallet"
            height={100}
            width={100}
          />
          <p className={Style.service_box_item_step}>
            <span>Step 2</span>
          </p>
          <h3>Connect Wallet </h3>
          <p>Connect Wallet, Discover, Buys NFTs, Sell NFTs and earn money</p>
        </div>
        <div className={Style.service_box_item}>
          <Image
            src={images.service3}
            alt="Start Trading"
            height={100}
            width={100}
          />
          <p className={Style.service_box_item_step}>
            <span>Step 1</span>
          </p>
          <h3>Start Trading </h3>
          <p>Connect Wallet, Discover, Buys NFTs, Sell NFTs and earn money</p>
        </div>
        <div className={Style.service_box_item}>
          <Image
            src={images.service4}
            alt="Earn Money"
            height={100}
            width={100}
          />
          <p className={Style.service_box_item_step}>
            <span>Step 4</span>
          </p>
          <h3>Earn Money </h3>
          <p>Connect Wallet, Discover, Buys NFTs, Sell NFTs and earn money</p>
        </div>
      </div>
    </div>
  );
};

export default Service;
