import React from "react";
import Image from "next/image";
import Style from "./Notification.module.css";
//internal import
import images from "../../../img/";
const Notification = () => {
  return (
    <div className={Style.notification}>
      <p>Notification</p>
      <div className={Style.notification_box}>
        <div className={Style.notification_box_img}>
          <Image
            src={images.user1}
            alt="profile image"
            width={50} 
            height={50}
          />
        </div>
        <div className={Style.notification_box_info}>
          <h4 className="text-sky-500 font-semibold">Anil Shrestha</h4>
          <p>Measure action your user ....</p>
          <small> 3 minutes ago</small>
        </div>
        <div>
          <span className={Style.notification_box_new}></span>
        </div>
      </div>
    </div>
  );
};

export default Notification;
