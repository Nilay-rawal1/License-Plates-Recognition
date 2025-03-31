import React, { useContext, useEffect, useState } from 'react'
import Login from './components/Auth/Login'
import EmployeeDashboard from './components/Dashboard/EmployeeDashboard'
import AdminDashboard from './components/Dashboard/AdminDashboard'
import { getLocalStorage } from './utils/localStorage'
import { AuthContext } from './context/AuthProvider'

const App = () => {

  // useEffect(() => {
  //   // setLocalStorage()
  //   getLocalStorage()
  // }, [])

  const [User, setUser] = useState(null)
  const handleLogin = (email, password) => {
    if (email == 'admin@me.com' && password == '123') {
      setUser("admin")


    }

    else if(email == 'emp1@me.com' && password == '123'){
      setUser('employee')

    }
    else {
      alert("Invaild Credenials")
    }

  }
  const data=  useContext(AuthContext)
  console.log(data)
  

  return (
    <>

      {!User ? <Login handleLogin={handleLogin} /> : ""}

      {User=='admin'?<AdminDashboard/>: <EmployeeDashboard/>}

      {/* <AdminDashboard /> */}

      {/* <EmployeeDashboard /> */}

    </>
  )
}

export default App
