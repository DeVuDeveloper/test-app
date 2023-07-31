import React from "react";
import { Table } from "./components/orders";
import useFetchOrders from "./hooks/UseFetchOrders";

const App = () => {
  const { orders, loading } = useFetchOrders();

  if (loading) {
    return <div>Loading...</div>;
  }

  return (
    <div>
      <Table orders={orders} />
    </div>
  );
};

export default App;


