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
    <tr className={fulfilled ? 'bg-green-100' : 'bg-white'}>
      <td className="px-6 py-4 whitespace-nowrap text-sm font-medium text-gray-900">{id}</td>
      <td className="px-6 py-4 whitespace-nowrap text-sm text-gray-500">{formatDate(created_at)}</td>
      <td className="px-6 py-4 whitespace-nowrap text-sm text-gray-500">{formatDate(pick_up_at)}</td>
      <td className="px-6 py-4 whitespace-nowrap text-sm text-gray-500">{customer_name}</td>
      <td className="px-6 py-4 whitespace-nowrap text-sm text-gray-500">{item}</td>
      <td className="px-6 py-4 whitespace-nowrap text-sm text-gray-500">{quantity}</td>
      <td className="px-6 py-4 whitespace-nowrap text-sm text-gray-500">
        <span className={`inline-flex items-center px-2.5 py-0.5 rounded-full ${fulfilled ? 'bg-green-100 text-green-800' : 'bg-yellow-100 text-yellow-800'}`}>
          {fulfilled ? 'Fulfilled' : 'In progress'}
        </span>
      </td>
      <td className="px-6 py-4 whitespace-nowrap text-right text-sm font-medium">
        {!fulfilled && (
          <button
            onClick={handleFulfillClick}
            className={`${
              isFulfilling
                ? 'bg-gray-300 text-gray-500 cursor-not-allowed'
                : 'bg-green-500 hover:bg-green-600 text-white'
            } px-3 py-1 rounded-lg focus:outline-none`}
            disabled={isFulfilling}
          >
            {isFulfilling ? 'Fulfilling...' : 'Fulfill'}
          </button>
        )}
      </td>
    </tr>
  );
};

export default OrderRow;






