import { useEffect, useState } from "react";

const useFetchOrders = () => {
  const [orders, setOrders] = useState([]);
  const [loading, setLoading] = useState(true);

  const fetchOrders = async () => {
    try {
      const response = await fetch("/api/orders");
      const data = await response.json();
      setOrders(data);
      setLoading(false);
    } catch (error) {
      console.error("Error fetching orders:", error);
    }
  };

  useEffect(() => {
    fetchOrders();
  }, []);

  return { orders, loading, fetchOrders };
};

export default useFetchOrders;






