import React, { useState, useEffect } from "react";
import TaskList from "../TaskList/TaskList";
import AllTask from "./AllTask";
import { useNavigate } from "react-router-dom";

const TaskListNumber = () => {
  const navigate = useNavigate();
  const [showTaskList, setShowTaskList] = useState(false);
  const [showAllTasks, setShowAllTasks] = useState(false);
  const [randomReview, setRandomReview] = useState(null);
  const [reviews, setReviews] = useState([]);
  const [totalTickets, setTotalTickets] = useState(0);

  useEffect(() => {
    const updateStats = () => {
      const storedTasks = JSON.parse(localStorage.getItem("tasks")) || [];
      setTotalTickets(storedTasks.length);

      const storedReviews = JSON.parse(localStorage.getItem("reviews")) || [];
      setReviews(storedReviews);
    };

    updateStats();
    window.addEventListener("storage", updateStats);
    return () => window.removeEventListener("storage", updateStats);
  }, []);

 

  return (
    <div className="flex flex-wrap mt-10 justify-between gap-6 screen">
      {showTaskList ? (
        <div className="w-full h-full">
          <button
            onClick={() => setShowTaskList(false)}
            className="mt-6 px-6 py-3 bg-gray-700 text-white rounded-xl hover:bg-gray-800 transition duration-300"
          >
            Go Back
          </button>
          <TaskList />
        </div>
      ) : showAllTasks ? (
        <div className="w-full h-full">
          <button
            onClick={() => setShowAllTasks(false)}
            className="mt-6 px-6 py-3 bg-gray-700 text-white rounded-xl hover:bg-gray-800 transition duration-300"
          >
            Go Back
          </button>
          <AllTask />
        </div>
      ) : (
        <>
          {/* 🔹 Click to Show Random Review */}
         

          {/* ✅ Show Random Review (if selected) */}
          {randomReview && (
            <div className="mt-4 p-6 bg-gray-800 text-white rounded-lg shadow-lg">
              <h3 className="text-lg font-bold">{randomReview.userName}</h3>
              <p className="text-sm mt-2">{randomReview.comment}</p>
            </div>
          )}

          {/* 🔹 Other Stats */}
          <div className="py-8 px-10 rounded-xl w-[45%] bg-green-500 shadow-lg hover:shadow-xl transition duration-300">
            <h2 className="text-4xl font-semibold text-white">😄 3</h2>
            <h3 className="text-xl font-medium text-white mt-2">Resolved Issues</h3>
          </div>

          {/* 🔹 Click to Show All Tasks */}
          <div
            className="py-8 px-10 rounded-xl w-[45%] bg-red-500 shadow-lg hover:shadow-xl transition duration-300 cursor-pointer"
            onClick={() => setShowAllTasks(true)}
          >
            <h2 className="text-4xl font-semibold text-white">😒 {totalTickets}</h2>
            <h3 className="text-xl font-medium text-white mt-2">Total Tickets Raised</h3>
          </div>

          {/* 🔹 Click to Show Task List */}
          <div
            onClick={() => setShowTaskList(true)}
            className="py-8 px-10 rounded-xl w-[45%] bg-gradient-to-br from-purple-500 to-indigo-600 cursor-pointer hover:bg-purple-600 transition duration-300"
          >
            <h2 className="text-4xl font-semibold text-white">🤔 150</h2>
            <h3 className="text-xl font-medium text-white mt-2">Reviews Featured</h3>
          </div>
          <div
            className="py-8 px-10 rounded-xl w-[45%] bg-blue-500 shadow-lg hover:shadow-xl transition duration-300 cursor-pointer"
            onClick={() => navigate("/accident")}
          >
            <h2 className="text-4xl font-semibold text-white">😕50k </h2>
            <h3 className="text-xl font-medium text-white mt-2">Accident Statistics</h3>
          </div>
        </>
      )}
    </div>
  );
};

export default TaskListNumber;
