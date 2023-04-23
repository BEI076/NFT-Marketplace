import React from "react";
import Link from "next/link";

// internal import
import Style from "./HelpCenter.module.css";
const HelpCenter = () => {

  const helpCener = [
    {
      name : "About",
      link : "about"
    },
    {
      name : "Contact Us",
      link : "contact-us"
    }
  ]
  return <div>HelpCenter</div>;
};

export default HelpCenter;
