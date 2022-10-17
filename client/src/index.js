import React from 'react';
import ReactDOM from 'react-dom/client';
import { BrowserRouter } from 'react-router-dom'
import { App } from './App';
import { ErrorProvider, UserProvider } from './hookComponents';

const root = ReactDOM.createRoot(document.getElementById('root'));
root.render(
  <>
    <ErrorProvider>
      <UserProvider>
        <BrowserRouter>
          <App/>
        </BrowserRouter>
      </UserProvider>
    </ErrorProvider>
  </>
);