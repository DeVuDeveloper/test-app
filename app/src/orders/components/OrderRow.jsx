import React, { useState, useEffect } from 'react';
import { formatDate } from '../utils/dateUtils';

const OrderRow = ({ order, onFulfillOrder }) => {
  const { id, created_at, pick_up_at, customer_name, item, quantity, fulfilled } = order;
  const [isFulfilling, setIsFulfilling] = useState(false);

  const handleFulfillClick = async () => {
    setIsFulfilling(true);

    try {
      await onFulfillOrder(order);
      setIsFulfilling(false);
      order.fulfilled = true;
    } catch (error) {
      
      setIsFulfilling(false);
    }
  };

  return (
    <tr>
      <td data-testid="order-id">{id}</td>
      <td data-testid="created-at">{formatDate(created_at)}</td>
      <td data-testid="pick-up-at">{formatDate(pick_up_at)}</td>
      <td data-testid="customer-name">{customer_name}</td>
      <td data-testid="item">{item}</td>
      <td data-testid="quantity">{quantity}</td>
      <td data-testid="fulfilled-status">{fulfilled ? 'Fulfilled' : 'In progress'}</td>
      <td>
        {!fulfilled && (
          <button data-testid="fulfill-button" onClick={handleFulfillClick} disabled={isFulfilling}>
            {isFulfilling ? 'Fulfilling...' : 'Fulfill order'}
          </button>
        )}
      </td>
    </tr>
  );
};

export default OrderRow;




