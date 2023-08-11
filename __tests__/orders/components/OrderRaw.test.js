import React from 'react';
import { render, fireEvent, act } from '@testing-library/react';
import OrderRow from "../../../app/src/orders/components/OrderRow";
import { formatDate } from '../../../app/src/orders/utils/dateUtils';

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
  it('displays order details and fulfill button', async () => {
    const mockFulfillOrder = jest.fn();
  
    let container;
  
    await act(async () => {
      container = render(
        <table>
          <tbody>
            <OrderRow order={mockOrder} onFulfillOrder={mockFulfillOrder} />
          </tbody>
        </table>
      ).container;
    });
  
    const elementsWithOrderId = container.querySelectorAll('td');
    expect(elementsWithOrderId[1].textContent).toBe(formatDate(mockOrder.created_at));
    expect(elementsWithOrderId[2].textContent).toBe(formatDate(mockOrder.pick_up_at));
    
    expect(elementsWithOrderId[3].textContent).toBe(mockOrder.customer_name);
    expect(elementsWithOrderId[4].textContent).toBe(mockOrder.item);
    expect(elementsWithOrderId[5].textContent).toBe(mockOrder.quantity.toString());
    expect(elementsWithOrderId[6].textContent).toBe(mockOrder.fulfilled ? 'Fulfilled' : 'In progress');
  
    expect(container).toBeInTheDocument();
  
    const fulfillButton = container.querySelector('button');
    expect(fulfillButton).toBeInTheDocument();
  
    await act(async () => {
      fireEvent.click(fulfillButton);
    });
  
    expect(mockFulfillOrder).toHaveBeenCalledWith(mockOrder);
  });
  
});

