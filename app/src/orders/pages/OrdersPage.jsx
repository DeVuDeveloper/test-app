import React, { useState, useEffect } from "react";
import OrderTable from "../components/OrderTable";
import Pagination from "../components/Pagination";
import useFetchOrders from "../hooks/UseFetchOrders";
import { getColumnValue, compareValues } from "../utils/sortingUtils";

const OrdersPage = () => {
  const [sortColumn, setSortColumn] = useState("id");
  const [sortDirection, setSortDirection] = useState("asc");
  const [currentPage, setCurrentPage] = useState(1);
  const ordersPerPage = 10;

  const handleSortChange = (column) => {
    let newSortDirection = "asc";

    if (sortColumn === column) {
      newSortDirection = sortDirection === "asc" ? "desc" : "asc";
    }

    setSortColumn(column);
    setSortDirection(newSortDirection);
  };

  const handlePaginationChange = (pageNumber) => {
    setCurrentPage(pageNumber);
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
  
      await fetchOrders();
    } catch (error) {
      console.error("Error fulfilling order:", error);
      throw error;
    }
  };
  

  const { orders, loading, fetchOrders } = useFetchOrders();

  const sortedOrders = orders.slice().sort((a, b) => {
    const columnA = getColumnValue(a, sortColumn);
    const columnB = getColumnValue(b, sortColumn);

    return sortDirection === "asc"
      ? compareValues(columnA, columnB)
      : compareValues(columnB, columnA);
  });

  const indexOfLastOrder = currentPage * ordersPerPage;
  const indexOfFirstOrder = indexOfLastOrder - ordersPerPage;
  const ordersToShow = sortedOrders.slice(indexOfFirstOrder, indexOfLastOrder);

  return (
    <div>
      <h2>Orders</h2>
      <OrderTable
        orders={ordersToShow}
        loading={loading}
        sortColumn={sortColumn}
        sortDirection={sortDirection}
        onSortChange={handleSortChange}
        onFulfillOrder={handleFulfillOrder}
      />
      <Pagination
        ordersPerPage={ordersPerPage}
        totalOrders={sortedOrders.length}
        currentPage={currentPage}
        paginate={handlePaginationChange}
      />
    </div>
  );
};

export default OrdersPage;

