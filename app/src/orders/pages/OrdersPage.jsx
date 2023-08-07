import React, { useState } from "react";
import OrderTable from "../components/OrderTable";
import useFetchOrders from "../hooks/UseFetchOrders";
import { getColumnValue, compareValues } from "../utils/sortingUtils";

const OrdersPage = () => {
  const { orders, loading } = useFetchOrders();
  const [sortColumn, setSortColumn] = useState("id");
  const [sortDirection, setSortDirection] = useState("asc");

  const handleSortChange = (column) => {
    let newSortDirection = "asc";

    if (sortColumn === column) {
      newSortDirection = sortDirection === "asc" ? "desc" : "asc";
    }

    setSortColumn(column);
    setSortDirection(newSortDirection);
  };

  const handleFulfillOrder = async (order) => {
    try {
      const response = await fetch(`/api/orders/${order.id}/fulfill`, {
        method: "PATCH",
        headers: {
          "Content-Type": "application/json",
        },
        body: JSON.stringify({ fulfilled: true }),
      });

      if (!response.ok) {
        throw new Error("Failed to fulfill order");
      }
    } catch (error) {
      console.error("Error fulfilling order:", error);
      throw error;
    }
  };

  const sortedOrders = orders.slice().sort((a, b) => {
    const columnA = getColumnValue(a, sortColumn);
    const columnB = getColumnValue(b, sortColumn);

    return sortDirection === "asc"
      ? compareValues(columnA, columnB)
      : compareValues(columnB, columnA);
  });

  return (
    <div>
      <h2>Orders</h2>
      <OrderTable
        orders={sortedOrders}
        loading={loading}
        sortColumn={sortColumn}
        sortDirection={sortDirection}
        onSortChange={handleSortChange}
        onFulfillOrder={handleFulfillOrder}
      />
    </div>
  );
};

export default OrdersPage;
