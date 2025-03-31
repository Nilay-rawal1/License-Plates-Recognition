import React from 'react';
import Header from '../others/Header'; // Ensure this is properly imported
import TaskListNumber from '../others/TaskListNumber'; // Ensure this is properly imported

const EmployeeDashboard = () => {
  return (
    <div className="p-10 bg-[#1C1C1C] text-white h-screen">
      {/* Header Section */}
      <Header />
      
      {/* Main Content Section */}
      <div className="m-5">
        <h1 className="flex justify-center  text-2xl">Welcome to Admin Dashboard !</h1>
      </div>

      {/* Task List Numbers */}
      <TaskListNumber />
    </div>
  );
};

export default EmployeeDashboard;
