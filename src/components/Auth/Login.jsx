import React, { useState } from 'react'

const Login = ({handleLogin}) => {

   
    //2-way binding
    const [email, setEmail] = useState('')
    const [password, setPassword] = useState('')
    const submitHandler = (e) => {
        e.preventDefault()
        // console.log("email",email)
        // console.log('"password',password)
        handleLogin(email,password)
        setEmail('')
        setPassword('')
    }
    
    return (
        <div className='flex h-screen w-screen items-center justify-center'>
            <div className='border-2 rounded-xl border-emerald-400 p-20'>

     <form onSubmit={submitHandler} className='  flex flex-col items-center justify-center'>
                 
                    <input value={email} onChange={(e)=>{
                       setEmail(e.target.value)  }} required className='w-60 text-white outline-none bg-transparent placeholder:text-grey-400 border-2  border-emerald-600 rounded-full py-3 px-5' type="email" placeholder='Enter your email' />
                   
                    <input value={password} onChange={(e)=>{
                        setPassword(e.target.value)
                    }} required className='w-60 text-white outline-none bg-transparent placeholder:text-grey-400 border-2  border-emerald-600 rounded-full mt-3 py-3 px-5' type="password" placeholder='Enter password' />
                    <button className=' w-60 mt-5 text-white outline-none border-none bg-emerald-500 placeholder:text-white   rounded-full  py-3 px-5' >Log In</button>
                </form>

            </div>
        </div>
    )
}

export default Login