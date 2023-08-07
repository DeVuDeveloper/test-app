import React, { useState, useEffect } from 'react';
import { formatDate } from '../utils/dateUtils';

const OrderRow = ({ order, onFulfillOrder }) => {
  const { id, created_at, pick_up_at, customer_name, item, quantity } = order;
  const [isFulfilling, setIsFulfilling] = useState(false);
  const [currentFulfilledStatus, setCurrentFulfilledStatus] = useState(false);

  useEffect(() => {
    setCurrentFulfilledStatus(order.fulfilled);
  }, [order]);

  const handleFulfillClick = async () => {
    setIsFulfilling(true);

    try {
      await onFulfillOrder(order);
      setIsFulfilling(false);
      setCurrentFulfilledStatus(true);
      storeFulfilledStatus(id, true);
    } catch (error) {
      console.error('Error fulfilling order:', error);
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
      <td data-testid="fulfilled-status">{currentFulfilledStatus ? 'Fulfilled' : 'In progress'}</td>
      <td>
        {!currentFulfilledStatus && (
          <button data-testid="fulfill-button" onClick={handleFulfillClick} disabled={isFulfilling}>
            {isFulfilling ? 'Fulfilling...' : 'Fulfill order'}
          </button>
        )}
      </td>
    </tr>
  );
};

const storeFulfilledStatus = (orderId, status) => {
  localStorage.setItem(`order_${orderId}_fulfilled`, status);
};

export default OrderRow;


