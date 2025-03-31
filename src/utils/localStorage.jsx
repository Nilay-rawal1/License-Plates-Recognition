import { data } from "autoprefixer";

const employees = [
    {
      "id": 1,
      "email": "emp1@me.com",
      "password": "123",
      "tasks": [
        {
          "taskTitle": "Prepare report",
          "taskDescription": "Prepare the quarterly sales report.",
          "date": "2025-01-21",
          "category": "Sales",
          "active": true,
          "newTask": true,
          "completed": false,
          "failed": false
        },
        {
          "taskTitle": "Update CRM",
          "taskDescription": "Ensure all client data is up to date in the CRM.",
          "date": "2025-01-22",
          "category": "Customer Management",
          "active": false,
          "newTask": false,
          "completed": true,
          "failed": false
        },
        {
          "taskTitle": "Team meeting",
          "taskDescription": "Attend the weekly team meeting and share updates.",
          "date": "2025-01-23",
          "category": "Meetings",
          "active": true,
          "newTask": true,
          "completed": false,
          "failed": false
        }
      ]
    },
    {
      "id": 2,
      "email": "emp2@me.com",
      "password": "123",
      "tasks": [
        {
          "taskTitle": "Fix website bug",
          "taskDescription": "Resolve the issue on the checkout page.",
          "date": "2025-01-21",
          "category": "Development",
          "active": true,
          "newTask": true,
          "completed": false,
          "failed": false
        },
        {
          "taskTitle": "Code review",
          "taskDescription": "Review the code submitted by team members.",
          "date": "2025-01-22",
          "category": "Code Review",
          "active": false,
          "newTask": false,
          "completed": true,
          "failed": false
        },
        {
          "taskTitle": "Database optimization",
          "taskDescription": "Optimize the database for better performance.",
          "date": "2025-01-23",
          "category": "Database",
          "active": true,
          "newTask": false,
          "completed": false,
          "failed": false
        }
      ]
    },
    {
      "id": 3,
      "email": "emp3@me.com",
      "password": "123",
      "tasks": [
        {
          "taskTitle": "Social media campaign",
          "taskDescription": "Plan and execute a new social media campaign.",
          "date": "2025-01-21",
          "category": "Marketing",
          "active": true,
          "newTask": true,
          "completed": false,
          "failed": false
        },
        {
          "taskTitle": "Client onboarding",
          "taskDescription": "Assist the new client with onboarding steps.",
          "date": "2025-01-22",
          "category": "Client Management",
          "active": false,
          "newTask": false,
          "completed": true,
          "failed": false
        }
      ]
    },
    {
      "id": 4,
      "email": "emp4@me.com",
      "password": "123",
      "tasks": [
        {
          "taskTitle": "Conduct survey",
          "taskDescription": "Analyze results from the customer feedback survey.",
          "date": "2025-01-21",
          "category": "Research",
          "active": false,
          "newTask": false,
          "completed": true,
          "failed": false
        },
        {
          "taskTitle": "Create presentation",
          "taskDescription": "Prepare the presentation for the monthly review meeting.",
          "date": "2025-01-22",
          "category": "Meetings",
          "active": true,
          "newTask": true,
          "completed": false,
          "failed": false
        },
        {
          "taskTitle": "Organize files",
          "taskDescription": "Reorganize the shared drive for better file management.",
          "date": "2025-01-23",
          "category": "Organization",
          "active": false,
          "newTask": true,
          "completed": false,
          "failed": true
        }
      ]
    },
    {
      "id": 5,
      "email": "emp5@me.com",
      "password": "123",
      "tasks": [
        {
          "taskTitle": "Design logo",
          "taskDescription": "Create a new logo for the upcoming product.",
          "date": "2025-01-21",
          "category": "Design",
          "active": true,
          "newTask": true,
          "completed": false,
          "failed": false
        },
        {
          "taskTitle": "User testing",
          "taskDescription": "Conduct user testing for the beta version.",
          "date": "2025-01-22",
          "category": "Testing",
          "active": true,
          "newTask": false,
          "completed": false,
          "failed": false
        },
        {
          "taskTitle": "Write documentation",
          "taskDescription": "Prepare technical documentation for the API.",
          "date": "2025-01-23",
          "category": "Documentation",
          "active": false,
          "newTask": false,
          "completed": true,
          "failed": false
        }
      ]
    }
  ];
  
  const admin = [
    {
      "id": 1,
      "email": "admin@me.com",
      "password": "123"
    }
  ];


  
  

export const setLocalStorage=()=>{
    localStorage.setItem('employees',JSON.stringify(employees))
    localStorage.setItem('admin',JSON.stringify(admin))
}

export const getLocalStorage=()=>{
   const employees=JSON.parse(localStorage.getItem('employees'))
   const admin=JSON.parse(localStorage.getItem('admin'))
   console.log(employees,admin)
  
}