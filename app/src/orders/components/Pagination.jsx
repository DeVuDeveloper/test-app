import React from "react";

const Pagination = ({ ordersPerPage, totalOrders, currentPage, paginate }) => {
  const pageNumbers = [];

  for (let i = 1; i <= Math.ceil(totalOrders / ordersPerPage); i++) {
    pageNumbers.push(i);
  }

  return (
    <nav className="mt-4 flex justify-center">
      <ul className="pagination flex">
        {pageNumbers.map((number) => (
          <li
            key={number}
            className={`page-item ${
              number === currentPage ? "bg-blue-500" : ""
            }`}
          >
            <a
              onClick={() => paginate(number)}
              href="#"
              className={`page-link py-2 px-3 rounded-lg ${
                number === currentPage
                  ? "bg-blue-500 text-white"
                  : "text-blue-500 hover:bg-blue-100"
              }`}
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


