import React from "react";
import { FontAwesomeIcon } from "@fortawesome/react-fontawesome";
import { faSpinner, faSort, faSortUp, faSortDown } from "@fortawesome/free-solid-svg-icons";
import OrderRow from "./OrderRow";

const OrderTable = ({ orders, loading, sortColumn, sortDirection, onSortChange, onFulfillOrder }) => {
  const handleSortChange = (column) => {
    onSortChange(column);
  };

  const getSortIcon = (column) => {
    if (sortColumn === column) {
      return sortDirection === "asc" ? faSortUp : faSortDown;
    }
    return faSort;
  };

  return (
    <table className="table orders-table">
      <thead>
        <tr>
          <th onClick={() => handleSortChange("id")} className="sortable">
            Order #{" "}
            <FontAwesomeIcon icon={getSortIcon("id")} data-testid="sort-icon-id" />
          </th>
          <th onClick={() => handleSortChange("ordered_at")} className="sortable">
            Ordered at{" "}
            <FontAwesomeIcon icon={getSortIcon("ordered_at")} data-testid="sort-icon-ordered-at" />
          </th>
          <th onClick={() => handleSortChange("pick_up_at")} className="sortable">
            Pick up at{" "}
            <FontAwesomeIcon icon={getSortIcon("pick_up_at")} data-testid="sort-icon-pick-up-at" />
          </th>
          <th onClick={() => handleSortChange("customer_name")} className="sortable">
            Customer Name{" "}
            <FontAwesomeIcon icon={getSortIcon("customer_name")} data-testid="sort-icon-customer-name" />
          </th>
          <th>Item</th>
          <th>Qty</th>
          <th>Status</th>
          <th>Actions</th>
        </tr>
      </thead>
      <tbody>
        {loading ? (
          <tr>
            <td colSpan="8" className="text-center">
              <FontAwesomeIcon icon={faSpinner} data-testid="loading-spinner" spin />
            </td>
          </tr>
        ) : (
          orders.map((order) => (
            <OrderRow key={order.id} order={order} onFulfillOrder={() => onFulfillOrder(order)} />
          ))
        )}
      </tbody>
    </table>
  );
};

export default OrderTable;
