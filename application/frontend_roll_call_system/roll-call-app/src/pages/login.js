import React, { Component } from "react";
import axios from "axios";

class login extends Component {
  constructor() {
    super();
    console.log(localStorage.getItem("authorization"));

    this.state = {
      username: "",
      password: ""
    };
    this.handleFormSubmit = this.handleFormSubmit.bind(this);
  }

  handleFormSubmit = event => {
    event.preventDefault();
    const endpoint = "https://rollcallapp.azurewebsites.net/api/authenticate";
    const username = this.refs.username.value;
    const password = this.refs.pass.value;

    const user_object = {
      username: username,
      password: password
    };

    axios.post(endpoint, user_object).then(res => {
      localStorage.setItem("authorization", res.data.token);
      return this.handleDashboard();
    });
  };

  handleDashboard() {
    let config = {
      headers: {
        authorization: "Bearer " + localStorage.getItem("authorization"),
      }
    }
    console.log(config);
    axios.get("https://rollcallapp.azurewebsites.net/api/getrole", config).then(res => {
      if (res.data === "teacher") {
        localStorage.setItem("role", res.data);
        this.props.history.push("/teacherhome");
      } else if (res.data === "student") {
        localStorage.setItem("role", res.data);
        this.props.history.push("/studenthome");
      } else {
        alert("Authentication failure");
      }
      console.log("localstorage", localStorage.getItem("role"));
    });
  }

  render() {
    return (
      <div>
        <div class="wrapper">
          <form class="form-signin" onSubmit={this.handleFormSubmit}>
            <h2 class="form-signin-heading">Please login</h2>
            <div className="form-group">
              <input ref="username" type="text"
                class="form-control"
                placeholder="User name"

              />
            </div>
            <div className="form-group">
              <input ref="pass" type="password"
                class="form-control"
                placeholder="password"

              />
            </div>
            <button class="btn btn-lg btn-primary btn-block" type="submit">
              Login
            </button>
          </form>
        </div>
      </div>
    );
  }
}
export default login;