import React from 'react';
import { formatDate } from '../utils/dateUtils';

const OrderRow = ({ order }) => {
  const { id, created_at, pick_up_at, customer_name, item, quantity, fulfilled } = order;

  return (
    <tr>
      <td>{id}</td>
      <td>{formatDate(created_at)}</td>
      <td>{formatDate(pick_up_at)}</td>
      <td>{customer_name}</td>
      <td>{item}</td>
      <td>{quantity}</td>
      <td>{fulfilled ? 'Fulfilled' : 'In progress'}</td>
      <td></td>
    </tr>
  );
};

export default OrderRow;