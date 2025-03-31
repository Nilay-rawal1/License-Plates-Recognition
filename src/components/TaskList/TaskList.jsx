import React, { useEffect, useState } from "react";

const TaskList = () => {
  const [users, setUsers] = useState([]);

  useEffect(() => {
    fetch("./src/utils/data.json") // Adjust path if needed
      .then((response) => response.json())
      .then((data) => setUsers(data.users))
      .catch((error) => console.error("Error fetching users:", error));
  }, []);

  return (
    <div
      id="tasklist"
      style={{ zIndex: 3 }}
      className="h-[70vh] overflow-x-auto flex items-start justify-start gap-6 flex-nowrap w-full py-5 px-6"
    >
      {users.map((user) => (
        <div
          key={user.userId}
          className="min-h-[300px] max-h-[80vh] flex-shrink-0 w-[320px] bg-gradient-to-br from-purple-500 to-indigo-600 p-6 rounded-2xl shadow-lg text-white overflow-hidden"
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
  );
};

export default TaskList;
