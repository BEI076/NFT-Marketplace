import React from "react";
import Style from "./Button.module.css";
interface Props {
  btnText: string;
  handleClick?: () => void;
}

const Button: React.FC<Props> = ({ btnText, handleClick }) => {
  return (
    <div className={Style.box}>
      <button className={Style.button} onClick={handleClick}>
        {btnText}
      </button>
    </div>
  );
};  

export default Button;
