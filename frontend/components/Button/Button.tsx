import React from "react";
import Style from "./Button.module.css";


import { BsSearch } from "react-icons/bs";
interface Props {
  btnText: string;
  handleClick?: () => void;
  icon?: React.ReactElement;
}

const Button: React.FC<Props> = ({ btnText,  handleClick , icon}) => {
  return (
    <div className={Style.box}>
      <button className={Style.button} onClick={handleClick}>
        {btnText}
        {icon && <span className={Style.icon}>{icon}</span>}
      </button>
    </div>
  );
};


export default Button;
