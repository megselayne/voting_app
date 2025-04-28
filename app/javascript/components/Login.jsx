import React from 'react';

const Login = ({ flashMessage }) => {
  return (
    <main className='login-page'>
      {flashMessage && <div className='alert alert-danger'>{flashMessage}</div>}
      <h1>Sign in to vote</h1>
      <form className='login-page__form' action='/users' method='post' aria-labelledby='login-form-title'>
        <input type='hidden' name='authenticity_token' value={document.querySelector('meta[name="csrf-token"]').content} />
        <label htmlFor='email'>Email</label>
        <input className='login-page__input' type='email' id='email' name='email' placeholder='myemail@example.com' required />
        <label htmlFor='password'>Password</label>
        <input className='login-page__input' type='password' id='password' name='password' placeholder='••••••••••••' required />
        <label htmlFor='zip_code'>Zip Code</label>
        <input className='login-page__input' type='text' id='zip_code' name='zip_code' placeholder='12345' required />
        <button type='submit' className='btn-primary'>Sign in</button>
      </form>
    </main>
  );
};

export default Login;