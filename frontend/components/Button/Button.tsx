import React from "react";

interface Props {
  btnText: string;
}

const Button: React.FC<Props> = ({ btnText }) => {
  return (
    <button>Button</button>
  );
};

export default Button;