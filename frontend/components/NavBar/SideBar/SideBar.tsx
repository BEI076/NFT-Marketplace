import React from "react";
interface SideBarProps {
  setOpenSideMenu: React.Dispatch<React.SetStateAction<boolean>>;
}

const SideBar: React.FC<SideBarProps> = ({ setOpenSideMenu }) => {
  return <div>SideBar</div>;
};

export default SideBar;
