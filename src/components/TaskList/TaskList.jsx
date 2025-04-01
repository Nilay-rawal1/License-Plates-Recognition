import React, { useEffect, useState } from "react";

const TaskList = () => {
  const [users, setUsers] = useState([]);
  const [viewMode, setViewMode] = useState("grid"); // Grid view by default

  useEffect(() => {
    fetch("./src/utils/data.json")
      .then((response) => response.json())
      .then((data) => setUsers(data.users))
      .catch((error) => console.error("Error fetching users:", error));
  }, []);

  // Function to toggle between grid and list view
  const toggleViewMode = (mode) => {
    setViewMode(mode);
  };

  return (
    <div>
      {/* View Mode Toggle */}
      <div className="flex justify-end mb-4">
        <button
          onClick={() => toggleViewMode("grid")}
          className={`py-2 px-4 rounded-l-md ${viewMode === "grid" ? "bg-purple-600 text-white" : "bg-gray-200 text-black"}`}
        >
          Grid View
        </button>
        <button
          onClick={() => toggleViewMode("list")}
          className={`py-2 px-4 rounded-r-md ${viewMode === "list" ? "bg-purple-600 text-white" : "bg-gray-200 text-black"}`}
        >
          List View
        </button>
      </div>

      {/* Task List */}
      <div
        id="tasklist"
        style={{ zIndex: 3 }}
        className={`${
          viewMode === "grid" ? "grid grid-cols-3 gap-6" : "flex flex-col gap-6"
        } w-full py-5 px-6`}
      >
        {users.map((user) => (
          <div
            key={user.userId}
            className={`min-h-[300px] max-h-[80vh] ${
              viewMode === "grid" ? "flex-shrink-0 w-[320px]" : "w-full"
            } bg-gradient-to-br from-purple-500 to-indigo-600 p-6 rounded-2xl shadow-lg text-white overflow-hidden`}
          >
            {/* Header: Name & Rating */}
            <div className="flex justify-between items-center border-b border-white/20 pb-3 mb-3">
              <h2 className="text-xl font-bold">{user.userName}</h2>
              <span className="bg-white/20 text-white px-3 py-1 rounded text-sm font-medium">
                ⭐ {user.currentRating}
              </span>
            </div>

            {/* User Details */}
            <div className="space-y-2 text-sm">
              <p className="flex items-center gap-2">
                📧 <span className="text-white/80">{user.email}</span>
              </p>
              <p className="flex items-center gap-2">
                🚗 <span className="text-white/80">{user.licensePlateNumber}</span>
              </p>
              <p className="flex items-center gap-2">
                🆔 <span className="text-white/80">{user.driverLicenseNumber}</span>
              </p>
            </div>

            {/* Reviews About the User */}
            <div className="mt-5 bg-white/10 p-4 rounded-xl overflow-y-auto max-h-[200px]">
              <h3 className="font-semibold text-white/90 mb-3">
                🔍 Reviews About {user.userName}
              </h3>
              <div className="space-y-3">
                {user.reviewsAboutYou.length > 0 ? (
                  user.reviewsAboutYou.map((review, index) => (
                    <div key={index} className="bg-white/20 p-3 rounded-lg shadow">
                      <p className="text-sm text-white/90">{review.review}</p>
                      <div className="text-xs text-white/70 flex justify-between mt-2">
                        <span>⭐ {review.rating}</span>
                        <span>{review.reviewDate}</span>
                      </div>
                    </div>
                  ))
                ) : (
                  <p className="text-white/60 text-sm">No reviews yet.</p>
                )}
              </div>
            </div>
          </div>
        ))}
      </div>
    </div>
  );
};

export default TaskList;
