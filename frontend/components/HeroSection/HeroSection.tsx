import React from "react";
import Link from "next/link";
import Image from "next/image";
import images from "../../img";


import Style from "./HeroSection.module.css";
import { Button } from "../componentindex";

import { BsSearch } from "react-icons/bs";

export const HeroSection = () => {
  return (
    <div className={Style.heroSection}>
      <div className={Style.heroSection_box}>
        <div className={Style.heroSection_box_left}>
          <h1>Discover, Collect and Sell NFTs 🖼️</h1>
          <p>
            Discover the most outstanding NFTs in all topics of life. Create your
            NTFs and sell them
          </p>
          <Button btnText="Start your search" /> 
        </div>
        <div className={Style.heroSection_box_right}>
          <Image
            src={images.hero}
            alt="hero section"
            width={600}
            height={100}
          />
        </div>
      </div>
    </div>
  );
};
