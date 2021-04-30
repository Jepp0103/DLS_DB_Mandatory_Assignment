import React from "react";
import "./css/App.css";
import { BrowserRouter, Route } from "react-router-dom";
import interceptors from "./interceptors";
import login from "./login";
import home from "./home";

function App() {
  return (
    <div className="App">
      <header className="App-header">
        <BrowserRouter>
          <Route exact path="/" component={login} />
          <Route exact path="/home" component={home} />
        </BrowserRouter>
      </header>
    </div>
  );
}

export default App;
