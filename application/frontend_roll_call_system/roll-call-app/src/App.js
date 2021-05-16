import React from "react";
import "./css/App.css";
import { BrowserRouter, Route } from "react-router-dom";
import interceptors from "./interceptors";
import login from "./pages/login";
import teacherHome from "./pages/teacherHome";
import studentHome from "./pages/studentHome";
import MyLecture from "./pages/studentHome";


function App() {
  return (
    <div className="App">
      <header className="App-header">
        <BrowserRouter>
          <Route exact path="/" component={login} />
          <Route exact path="/teacherhome" component={teacherHome} />
          <Route exact path="/studenthome" component={studentHome} />
		  <Route exact path="/currentlectures/:id" component={MyLecture} />
        </BrowserRouter>
      </header>
    </div>
  );
}

export default App;
