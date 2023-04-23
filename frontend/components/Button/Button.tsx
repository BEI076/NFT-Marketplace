import React from "react";

interface Props {
  btnText: string;
}

const Button: React.FC<Props> = ({ btnText }) => {
  return <button>{btnText}</button>;
};

export default Button;
