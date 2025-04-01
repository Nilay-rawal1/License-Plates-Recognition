// src/context/AuthProvider.jsx

import React, { createContext, useState } from "react";

// Create context
const AuthContext = createContext();

// AuthProvider Component
const AuthProvider = ({ children }) => {
  const [user, setUser] = useState(null);

  const login = (userData) => {
    setUser(userData);
  };

  const logout = () => {
    setUser(null);
  };

  return (
    <AuthContext.Provider value={{ user, login, logout }}>
      {children}
    </AuthContext.Provider>
  );
};

// Default export AuthProvider
export default AuthProvider;
