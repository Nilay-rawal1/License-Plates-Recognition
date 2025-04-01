import React from "react";
import { Link } from "react-router-dom";

const Header = () => {
  return (
    <div className="flex items-end justify-between">
      <h1 className="text-2xl font-medium">
        Hello <br />
        <span className="text-3xl font-semibold">Admin</span>
      </h1>

      <button
        onClick={() => {
          alert("User logged out");
          window.location.href = "/login"; 
        }}
        className="bg-red-600 text-lg font-medium text-white px-5 py-2 rounded-sm hover:bg-red-700 transition"
      >
        Log Out
      </button>
    </div>
  );
};

export default Header;
