import React from "react";

//INTERNAL IMPORT
import Style from "./Title.module.css";

interface TitlePros {
  heading?: string;
  paragraph?: string;
}

const Title: React.FC<TitlePros> = ({ heading, paragraph }) => {
  return (
    <div className={Style.title}>
      <div className={Style.title_box}>
        <h2>{heading}</h2>
        <p>{paragraph}</p>
      </div>
    </div>
  );
};

export default Title;
