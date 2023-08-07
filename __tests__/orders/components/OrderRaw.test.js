import React from 'react';
import { render, fireEvent } from '@testing-library/react';
import OrderRow from "../../../app/src/orders/components/OrderRow";
import '@testing-library/jest-dom/extend-expect'; 

describe('OrderRow component', () => {
  const mockOrder = {
    id: 1,
    created_at: '2023-08-07T12:00:00Z',
    pick_up_at: '2023-08-10T14:00:00Z',
    customer_name: 'John Doe',
    item: 'Product X',
    quantity: 3,
    fulfilled: false,
  };

  it('displays order details and fulfill button', () => {
    const mockFulfillOrder = jest.fn();
  
    const { getByTestId, getByRole } = render(
      <table>
        <tbody>
          <OrderRow order={mockOrder} onFulfillOrder={mockFulfillOrder} />
        </tbody>
      </table>
    );
  
    expect(getByTestId('order-id')).toBeInTheDocument();
    expect(getByTestId('customer-name')).toBeInTheDocument();
    expect(getByTestId('item')).toBeInTheDocument();
    expect(getByTestId('quantity')).toBeInTheDocument();
    expect(getByTestId('fulfilled-status')).toBeInTheDocument();
  
    const fulfillButton = getByRole('button', { name: 'Fulfill order' });
    expect(fulfillButton).toBeInTheDocument();
  
    fireEvent.click(fulfillButton);
    expect(mockFulfillOrder).toHaveBeenCalledWith(mockOrder);
  });
});
