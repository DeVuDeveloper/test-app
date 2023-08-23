import React from "react";
import OrdersPage from "../../../app/src/orders/pages/OrdersPage";
import { render, screen, fireEvent } from '@testing-library/react';
import '@testing-library/jest-dom/';

jest.mock("../../../app/src/orders/hooks/UseFetchOrders", () => {
  return () => ({
    orders: [
    ],
    loading: false,
  });
});

describe("OrdersPage", () => {
  it("renders the OrdersPage component", () => {
    render(<OrdersPage />);
  
    const header = screen.getByText("Orders");
    expect(header).toBeInTheDocument();
  });

  it("sorts orders when clicking on table headers", () => {
    render(<OrdersPage />);

    const idHeader = screen.getByRole("columnheader", { name: /Order #/i });
    fireEvent.click(idHeader);

    const sortedHeader = screen.getByTestId("sort-icon-id");
    expect(sortedHeader).toHaveClass("fa-sort-down");
  });
});
