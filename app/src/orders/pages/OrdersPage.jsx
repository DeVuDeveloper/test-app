import React, { useState } from "react";
import OrderTable from "../components/OrderTable";
import Pagination from "../components//Pagination";
import useFetchOrders from "../hooks/UseFetchOrders";
import { getColumnValue, compareValues } from "../utils/sortingUtils";

const OrdersPage = () => {
  const { orders, loading } = useFetchOrders();
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

  const sortedOrders = orders.slice().sort((a, b) => {
    const columnA = getColumnValue(a, sortColumn);
    const columnB = getColumnValue(b, sortColumn);

    return sortDirection === "asc"
      ? compareValues(columnA, columnB)
      : compareValues(columnB, columnA);
  });

  const indexOfLastOrder = currentPage * ordersPerPage;
  const indexOfFirstOrder = indexOfLastOrder - ordersPerPage;
  const currentOrders = sortedOrders.slice(indexOfFirstOrder, indexOfLastOrder);

  const paginate = (pageNumber) => {
    setCurrentPage(pageNumber);
  };

  return (
    <div>
      <h2>Orders</h2>
      <OrderTable
        orders={currentOrders}
        loading={loading}
        sortColumn={sortColumn}
        sortDirection={sortDirection}
        onSortChange={handleSortChange}
      />
      <Pagination
        ordersPerPage={ordersPerPage}
        totalOrders={sortedOrders.length}
        paginate={paginate}
      />
    </div>
  );
};

export default OrdersPage;

