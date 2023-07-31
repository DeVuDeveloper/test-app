import React from 'react';
import OrderRow from './OrderRow';

const OrderTable = ({ orders }) => (
  <table className="table orders-table">
    <thead>
      <tr>
        <th>Order #</th>
        <th>Ordered at</th>
        <th>Pick up at</th>
        <th>Customer Name</th>
        <th>Item</th>
        <th>Qty</th>
        <th>Status</th>
        <th>Actions</th>
      </tr>
    </thead>
    <tbody>
      {orders.map((order) => (
        <OrderRow key={order.id} order={order} />
      ))}
    </tbody>
  </table>
);

export default OrderTable;
