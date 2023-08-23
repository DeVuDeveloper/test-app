import React from 'react';
import ReactDOM from 'react-dom/client';
import App from '../../src/orders/App';
import ErrorBoundary from '../../src/orders/components/ErrorBoundary';

const rootElement = document.getElementById('root');

ReactDOM.createRoot(rootElement).render(
  <React.StrictMode>
    <ErrorBoundary>
      <App />
    </ErrorBoundary>
  </React.StrictMode>
);