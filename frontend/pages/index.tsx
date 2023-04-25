import React from "react";
import Style from "../styles/index.module.css";
import {
  HeroSection,
  Service,
  BigNFTSilder,
  Subscribe,
  Title,
  Category,
} from "@/components/componentindex";
const Home = () => {
  return (
    <div className={Style.homePage}>
      <HeroSection />
      <Service />
      <BigNFTSilder />
      <Title
        heading="Browse By Category"
        paragraph="Explore the NFTs in the most featured categories"
      />
      <Category />
      <Subscribe />
    </div>
  );
};

export default Home;
