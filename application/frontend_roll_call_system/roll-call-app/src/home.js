import React, { Component } from "react";
import styled from 'styled-components';
import "./css/home.css";
import axios from "axios";



class home extends Component {
  constructor(props) {
    super(props);
    this.state = {

      isLoaded: false,
      classes: []
    };
  }

  componentDidMount() {
    axios.get("http://localhost:4000/api/classes")
      .then(result => {
        console.log("result", result.data)

        for (var i = 0; i < result.data.length; i++) {
          this.state.classes.push(result.data[i].name);
        }

        console.log("classes", this.state.classes)
        this.setState({
          isLoaded: true,
        });
      })
      .catch(error => {
        this.setState({
          isLoaded: true,
          error
        });
      })
  }
  handleLogout() {
    localStorage.clear();
    window.location.href = "/";
  }

  render() {
    const { error, isLoaded, classes } = this.state;
    return (
      <div id="homeStudentRollCall">
        <h1>School roll call</h1>
        <div id="classDiv">
          <b>Current classes:</b>
          <ul>
            {this.state.classes}
          </ul>
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
          href="#!"
          onClick={this.handleLogout}
          className="d-b td-n pY-5 bgcH-grey-100 c-grey-700">
          <i className="ti-power-off mR-10"></i>
          <span>Logout</span>
        </a>
      </div >
    );
    // }
  }
}
export default home;