import React, { Component } from "react";
import styled from 'styled-components';
import "./css/home.css";
// const client = require('./client');


class home extends Component {
  constructor(props) {
    super(props);
    this.state = { classes: [] };
  }

  // componentDidMount() {
  //   client({ method: 'GET', path: '/api/employees' }).done(response => {
  //     this.setState({ employees: response.entity._embedded.employees });
  //   });
  // }

  handleLogout() {
    localStorage.clear();
    window.location.href = "/";
  }

  render() {
    return (

      <div id="homeStudentRollCall">
        <h1>School roll call</h1>
        <div id="classDiv">
          <b>Current classes:</b>

        </div>
        <div id="excStudentsDiv">
          <b>Expected students:</b>

        </div>
        <div id="attendingStudentsDiv">
          <b>Attending students:</b>
        </div>
        <div id="gpsDiv">
          <b>GPS:</b>

        </div  >
        <div id="currentCourseDiv">
          <b>Current course:</b>

        </div>
        <div id="currentLectureDiv">
          <b>Current lecture:</b>

        </div>
        <div id="networkDiv">
          <b>Network:</b>

        </div>
        <a id="logout"
          href="javascript:void(0);"
          onClick={this.handleLogout}
          className="d-b td-n pY-5 bgcH-grey-100 c-grey-700">
          <i className="ti-power-off mR-10"></i>
          <span>Logout</span>
        </a>
      </div>
    );
  }
}
export default home;