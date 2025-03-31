import React, { useState, useEffect } from "react";
const AllTask = () => {
    const [tasks, setTasks] = useState([]);

    useEffect(() => {
      // Retrieve tasks from LocalStorage
      const storedTasks = JSON.parse(localStorage.getItem("tasks")) || [];
      setTasks(storedTasks);
    }, []);
  return (
    <div className="bg-[#2a2a2a] p-6 mt-10 rounded-lg">
    <h2 className="text-white text-xl font-semibold mb-4">📋 Saved Tickets</h2>

    {tasks.length === 0 ? (
      <p className="text-gray-400">No Tickets available.</p>
    ) : (
      <div className="space-y-4">
        {tasks.map((task, index) => (
          <div key={index} className="bg-[#1c1c1c] p-4 rounded-md shadow-md">
            <h3 className="text-lg text-emerald-400 font-semibold">{task.title}</h3>
            <p className="text-gray-300 text-sm">📅 Date: {task.date}</p>
            <p className="text-gray-300 text-sm">👤 Assigned To: {task.assignedTo}</p>
            <p className="text-gray-300 text-sm">🗂 Category: {task.category}</p>
            <p className="text-gray-400 text-sm mt-2">{task.description}</p>
          </div>
        ))}
      </div>
    )}
  </div>
  )
}



export default AllTask