import React from "react";

const Pagination = ({ ordersPerPage, totalOrders, paginate }) => {
  const pageNumbers = [];

  for (let i = 1; i <= Math.ceil(totalOrders / ordersPerPage); i++) {
    pageNumbers.push(i);
  }

  return (
    <nav>
    <ul className="pagination">
      {pageNumbers.map((number) => (
        <li key={number} className="page-item">
          <a
            onClick={() => paginate(number)}
            href="#"
            className="page-link"
            data-testid={`pagination-link-${number}`}
          >
            {number}
          </a>
        </li>
      ))}
    </ul>
  </nav>
  );
};

export default Pagination;
