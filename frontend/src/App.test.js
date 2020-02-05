import React from "react";
import { render } from "@testing-library/react";
import App from "./App";

test("renders Search bar", () => {
  const { getByText } = render(<App />);
  const linkElement = getByText(/Filter by player name/i);
  expect(linkElement).toBeInTheDocument();
});
