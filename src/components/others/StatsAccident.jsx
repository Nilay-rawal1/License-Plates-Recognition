import React, { useState } from "react";
import { Line } from "react-chartjs-2";
import { Chart as ChartJS, CategoryScale, LinearScale, PointElement, LineElement, Title, Tooltip, Legend } from "chart.js";

// Register Chart.js components
ChartJS.register(CategoryScale, LinearScale, PointElement, LineElement, Title, Tooltip, Legend);

const ComparisonChart = () => {
  // Updated Data State with City Stats
  const [cityData, setCityData] = useState({
    nyc: [50000, 15000, 10000, 25000, 10000], // Example data for NYC: (Accidents, Rash Driving, Traffic Violations, Road Safety, Urban Infrastructure)
    delhi: [35000, 12000, 8000, 20000, 8000], // Example data for Delhi
    london: [10000, 3000, 2000, 5000, 2000], // Example data for London
    tokyo: [5000, 2000, 1500, 3500, 1500], // Example data for Tokyo
  });

  const [selectedCity, setSelectedCity] = useState("nyc");
  const [modalOpen, setModalOpen] = useState(false);

  const data = {
    labels: ['Accidents', 'Rash Driving', 'Traffic Violations', 'Road Safety', 'Urban Infrastructure'],
    datasets: [
      {
        label: "NYC",
        data: cityData.nyc,
        borderColor: 'rgba(255, 99, 132, 1)', // Red for NYC
        backgroundColor: 'rgba(255, 99, 132, 0.2)', // Red with transparency for area shadow
        fill: true, // Creates the area shadow
        tension: 0.4, // Smooth curves
        borderWidth: 2,
      },
      {
        label: "Delhi",
        data: cityData.delhi,
        borderColor: 'rgba(0, 255, 255, 1)', // Cyan for Delhi (highlighted)
        backgroundColor: 'rgba(0, 255, 255, 0.3)', // Cyan with transparency for area shadow
        fill: true, // Creates the area shadow
        tension: 0.4, // Smooth curves
        borderWidth: 2,
        pointBackgroundColor: 'rgba(0, 255, 255, 1)', // Same cyan color for points
      },
      {
        label: "London",
        data: cityData.london,
        borderColor: 'rgba(255, 165, 0, 1)', // Orange for London
        backgroundColor: 'rgba(255, 165, 0, 0.3)', // Orange with transparency for area shadow
        fill: true, // Creates the area shadow
        tension: 0.4, // Smooth curves
        borderWidth: 2,
      },
      {
        label: "Tokyo",
        data: cityData.tokyo,
        borderColor: 'rgba(128, 0, 128, 1)', // Purple for Tokyo
        backgroundColor: 'rgba(128, 0, 128, 0.3)', // Purple with transparency for area shadow
        fill: true, // Creates the area shadow
        tension: 0.4, // Smooth curves
        borderWidth: 2,
      },
    ],
  };

  const options = {
    responsive: true,
    animation: {
      duration: 1000, // Smooth transition
    },
    plugins: {
      title: {
        display: true,
        text: 'Accidents & Rash Driving Comparison',
        font: {
          size: 24,
          weight: 'bold',
          family: 'Arial, sans-serif',
        },
        color: '#fff',
      },
      tooltip: {
        backgroundColor: 'rgba(0, 0, 0, 0.7)',
        titleFont: { size: 14, family: 'Arial, sans-serif' },
        bodyFont: { size: 12, family: 'Arial, sans-serif' },
        callbacks: {
          label: (context) => {
            const label = context.dataset.label || '';
            const value = context.raw;
            return `${label}: ${value} incidents`;
          }
        }
      },
      legend: {
        labels: {
          color: '#fff',
          font: { size: 14, family: 'Arial, sans-serif' },
        },
      },
    },
    scales: {
      x: {
        grid: {
          color: 'rgba(255, 255, 255, 0.1)',
        },
        ticks: {
          color: '#fff',
          font: {
            size: 14,
          },
        },
      },
      y: {
        grid: {
          color: 'rgba(255, 255, 255, 0.1)',
        },
        ticks: {
          color: '#fff',
          font: {
            size: 14,
          },
        }
      },
    }
  };

  // Handle city change dynamically
  const handleCityChange = (event) => {
    setSelectedCity(event.target.value);
    setModalOpen(true); // Open modal when a city is selected
  };

  // Close modal
  const closeModal = () => {
    setModalOpen(false);
  };

  const getCityStats = (city) => {
    const stats = {
      nyc: "New York City (NYC) has one of the highest rates of traffic accidents, with 50,000+ accidents annually. The city has stringent road safety regulations and licensing procedures.",
      delhi: "Delhi sees around 35,000+ accidents annually. Rash driving is a significant concern, with a high number of fatalities due to road accidents.",
      london: "London has a relatively lower accident rate compared to other major cities, with an estimated 10,000+ accidents per year. Strict road safety laws and awareness programs help in reducing accidents.",
      tokyo: "Tokyo is known for its well-maintained roads, with fewer accidents. However, there are still around 5,000+ accidents reported annually, mostly related to rash driving and violations.",
    };
    return stats[city] || "No data available.";
  };

  return (
    <div className="bg-black p-8 rounded-xl max-w-3xl mx-auto">
      <h1 className="text-center text-3xl font-bold text-white mb-6">
        Accidents & Rash Driving Comparison
      </h1>
      <div className="mb-6 flex justify-center">
        <select
          className="bg-gray-800 text-white p-3 rounded-lg focus:outline-none"
          value={selectedCity}
          onChange={handleCityChange}
        >
          <option value="nyc">New York City (NYC)</option>
          <option value="delhi">Delhi</option>
          <option value="london">London</option>
          <option value="tokyo">Tokyo</option>
        </select>
      </div>
      <div className="border-4 border-gray-600 p-6 rounded-lg">
        <Line data={data} options={options} />
      </div>

      {/* Modal for City Stats */}
      {modalOpen && (
        <div className="fixed inset-0 bg-black bg-opacity-60 backdrop-blur-sm flex justify-center items-center z-50 transition-all ease-in-out duration-300">
          <div className={`bg-white p-6 rounded-xl max-w-md w-full transform transition-all ease-in-out duration-300 ${modalOpen ? 'scale-100 opacity-100' : 'scale-95 opacity-0'}`}>
            <button
              onClick={closeModal}
              className="absolute top-4 right-4 text-xl text-gray-500 hover:text-red-500 transition duration-300"
            >
              &times;
            </button>
            <h2 className="text-2xl font-semibold mb-4 text-center text-gray-800">City Stats & Facts</h2>
            <p className="text-gray-800">{getCityStats(selectedCity)}</p>
          </div>
        </div>
      )}

      {/* Go Back Button */}
      <div className="mt-6 flex justify-center">
        <button
          onClick={() => window.history.back()}
          className="bg-gray-800 text-white p-3 rounded-lg focus:outline-none"
        >
          Go Back
        </button>
      </div>
    </div>
  );
};

export default ComparisonChart;
