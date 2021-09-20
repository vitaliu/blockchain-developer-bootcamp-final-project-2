import React, {useState} from 'react';
import ReactDOM from 'react-dom';
import './index.css';
import App from './App';
import reportWebVitals from './reportWebVitals';
import { MoralisProvider } from 'react-moralis';
import { config } from 'dotenv'
const { REACT_APP_MORALIS_APPLICATION_ID, REACT_APP_MORALIS_SERVER_URL } = process.env;
const APP_ID  =  REACT_APP_MORALIS_APPLICATION_ID
const SERVER_URL =  REACT_APP_MORALIS_SERVER_URL

console.log(APP_ID)

ReactDOM.render(
  <React.StrictMode>
    <MoralisProvider appId={APP_ID} serverUrl={SERVER_URL}>
      <App />
    </MoralisProvider>

  </React.StrictMode>,
  document.getElementById('root')
);

// If you want to start measuring performance in your app, pass a function
// to log results (for example: reportWebVitals(console.log))
// or send to an analytics endpoint. Learn more: https://bit.ly/CRA-vitals
reportWebVitals();
