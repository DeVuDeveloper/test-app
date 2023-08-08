import React, { useState } from 'react';
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
      <td>Order ID: {id}</td>
      <td>{formatDate(created_at)}</td>
      <td>{formatDate(pick_up_at)}</td>
      <td>{customer_name}</td>
      <td>{item}</td>
      <td>{quantity}</td>
      <td>{fulfilled ? 'Fulfilled' : 'In progress'}</td>
      <td>
        {!fulfilled && (
          <button onClick={handleFulfillClick} disabled={isFulfilling}>
            {isFulfilling ? 'Fulfilling...' : 'Fulfill order'}
          </button>
        )}
      </td>
    </tr>
  );
};

export default OrderRow;





