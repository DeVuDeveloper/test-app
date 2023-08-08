import React from 'react';
import { render, screen, fireEvent } from '@testing-library/react';
import OrderTable from '../../../app/src/orders/components/OrderTable';
import '@testing-library/jest-dom/';

describe('OrderTable Component', () => {
  const fakeOrders = [
  
  ];

  it('displays sorting icons correctly', () => {
    render(
      <OrderTable
        orders={fakeOrders}
        loading={false}
        sortColumn="id"
        sortDirection="asc"
        onSortChange={() => {}}
      />
    );

    const idColumnHeader = screen.getByText('Order #');
    const idSortIcon = screen.getByTestId('sort-icon-id');

    expect(idColumnHeader).toBeInTheDocument();
    expect(idSortIcon).toBeInTheDocument();
  });

  it('changes sort direction and icon when column header is clicked', () => {
    const handleSortChangeMock = jest.fn();
    render(
      <OrderTable
        orders={fakeOrders}
        loading={false}
        sortColumn="ordered_at"
        sortDirection="desc"  // Promenjeno u "desc" za sort-up
        onSortChange={handleSortChangeMock}
      />
    );
  
    const orderedAtColumnHeader = screen.getByText('Ordered at');
    const orderedAtSortIcon = screen.getByTestId('sort-icon-ordered-at');
  
    fireEvent.click(orderedAtColumnHeader);
  
    expect(handleSortChangeMock).toHaveBeenCalledWith('ordered_at');
    expect(orderedAtSortIcon).toHaveAttribute('data-icon', 'sort-down');
  });
  
  it('displays loading spinner when loading is true', () => {
    render(
      <OrderTable
        orders={fakeOrders}
        loading={true}
        sortColumn="id"
        sortDirection="asc"
        onSortChange={() => {}}
      />
    );

    const spinner = screen.getByTestId('loading-spinner');

    expect(spinner).toBeInTheDocument();
  });

});



