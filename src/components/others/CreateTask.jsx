import React, { useState } from "react";

const CreateTask = () => {
  const [formData, setFormData] = useState({
    title: "",
    date: "",
    assignedTo: "",
    category: "",
    description: "",
  });

  // Handle Input Change
  const handleChange = (e) => {
    setFormData({
      ...formData,
      [e.target.name]: e.target.value,
    });
  };

  // Handle Form Submission
  const handleSubmit = (e) => {
    e.preventDefault();

    // Get existing tasks from LocalStorage or initialize an empty array
    const existingTasks = JSON.parse(localStorage.getItem("tasks")) || [];

    // Add new task to the array
    const updatedTasks = [...existingTasks, formData];

    // Save back to LocalStorage
    localStorage.setItem("tasks", JSON.stringify(updatedTasks));

    // Clear form after submission
    setFormData({
      title: "",
      date: "",
      assignedTo: "",
      category: "",
      description: "",
    });

    alert("Task Submitted Successfully!");
  };

  return (
    <div className="bg-[#1c1c1c] p-5 mt-10">
      <form
        className="flex w-full flex-wrap items-start justify-between"
        onSubmit={handleSubmit}
      >
        <div className="w-1/2">
          <div>
            <h3 className="text-sm text-gray-300 mb-0.5">Ticket Title</h3>
            <input
              className="text-sm py-1 px-2 w-4/5 rounded outline-none bg-transparent border-[1px] border-gray-400 mb-4"
              type="text"
              placeholder="Raise the tickets"
              name="title"
              value={formData.title}
              onChange={handleChange}
              required
            />
          </div>

          <div>
            <h3 className="text-sm text-gray-300 mb-0.5">Date</h3>
            <input
              className="text-sm py-1 px-2 w-4/5 rounded outline-none bg-transparent border-[1px] border-gray-400 mb-4"
              type="date"
              name="date"
              value={formData.date}
              onChange={handleChange}
              required
            />
          </div>

          <div>
            <h3 className="text-sm text-gray-300 mb-0.5">Assign to</h3>
            <input
              className="text-sm py-1 px-2 w-4/5 rounded outline-none bg-transparent border-[1px] border-gray-400 mb-4"
              type="text"
              placeholder="Driver License ID"
              name="assignedTo"
              value={formData.assignedTo}
              onChange={handleChange}
              required
            />
          </div>

          <div>
            <h3 className="text-sm text-gray-300 mb-0.5">Category</h3>
            <input
              className="text-sm py-1 px-2 w-4/5 rounded outline-none bg-transparent border-[1px] border-gray-400 mb-4"
              type="text"
              placeholder="Drink & Drive, Review, etc."
              name="category"
              value={formData.category}
              onChange={handleChange}
              required
            />
          </div>
        </div>

        <div className="w-2/5 flex flex-col items-start">
          <h3 className="text-sm text-gray-300 mb-0.5">Description</h3>
          <textarea
            className="w-full h-44 text-sm py-2 px-4 rounded outline-none bg-transparent border-[1px] border-gray-400 mb-4"
            name="description"
            value={formData.description}
            onChange={handleChange}
            required
          ></textarea>
          <button
            type="submit"
            className="bg-emerald-500 py-3 hover:bg-emerald-600 rounded px-5 text-sm w-full mt-4"
          >
            Submit Task
          </button>
        </div>
      </form>
    </div>
  );
};

export default CreateTask;
