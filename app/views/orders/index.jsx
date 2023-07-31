import { createRoot } from "react-dom/client";
import App from "/app/src/App";

const element = document.querySelector("[data-order-table]");
if (element) {
  createRoot(element).render(<App />);
}
