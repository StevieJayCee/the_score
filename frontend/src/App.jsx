import React, { useState } from "react";
import "./App.css";

import { ApolloProvider } from "react-apollo";
import { createClient } from "./util/apollo";
import Players from "./Players";
import Search from "./Search";

function App() {
  const client = createClient();
  const [variables, setVariables] = useState({});
  function onFormSubmit(event) {
    setVariables(event);
    console.log("seconds: ", event);
  }
  return (
    <React.StrictMode>
      <div className="App">
        <header className="App-header"></header>
        <ApolloProvider client={client}>
          <Search onFormSubmit={onFormSubmit} />
          <Players variables={variables} />
        </ApolloProvider>
      </div>
    </React.StrictMode>
  );
}

export default App;
