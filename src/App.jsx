// src/App.jsx

import React, { useState } from "react";
import { BrowserRouter as Router, Routes, Route, Navigate, useNavigate } from "react-router-dom";
import Login from "./components/Auth/Login";
import EmployeeDashboard from "./components/Dashboard/EmployeeDashboard";
import AdminDashboard from "./components/Dashboard/AdminDashboard";
import StatsAccident from "./components/others/StatsAccident";
// Import default export
import AuthProvider from "./context/AuthProvider"; 

const App = () => {
  return (
    <AuthProvider>
      <Router>
        <Routes>
          <Route path="/" element={<Navigate to="/login" />} />
          <Route path="/login" element={<LoginPage />} />
          <Route path="/admin-dashboard" element={<AdminDashboard />} />
          <Route path="/employee-dashboard" element={<EmployeeDashboard />} />
          <Route path="/accident" element={<StatsAccident />} />
        </Routes>
      </Router>
    </AuthProvider>
  );
};

// Login Page Component with Redirect on Successful Login
const LoginPage = () => {
  const navigate = useNavigate();
  const [error, setError] = useState("");

  const handleLogin = (email, password) => {
    email = email.trim().toLowerCase(); // Normalize email input

    if (email === "admin@me.com" && password === "123") {
      navigate("/admin-dashboard"); // Redirect to Admin Dashboard
    } else if (email === "emp1@me.com" && password === "123") {
      navigate("/employee-dashboard"); // Redirect to Employee Dashboard
    } else {
      setError("Invalid Credentials");
    }
  };

  return <Login handleLogin={handleLogin} error={error} />;
};

export default App;
