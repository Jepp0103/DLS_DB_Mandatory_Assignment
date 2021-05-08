import React, { Component } from "react";
import styled from 'styled-components';
import "./css/home.css";
import axios from "axios";



class home extends Component {
  constructor(props) {
    super(props);
    this.getClasses = this.getClasses.bind(this);
    this.getStudents = this.getExpectedStudents.bind(this);
    this.state = {
      isLoaded: false,
      classes: [],
      students: []
    };
  }

  componentDidMount() {
    this.getClasses();
    this.getExpectedStudents();
  }

  getClasses() {
    axios.get("http://localhost:4000/api/classes")
      .then(result => {
        console.log("result", result.data)
        for (var i = 0; i < result.data.length; i++) {
          this.state.classes.push(result.data[i].name);
        }
        console.log("classes", this.state.classes)
        this.setState({
          isLoaded: false,
        });
      })
      .catch(error => {
        this.setState({
          isLoaded: false,
          error
        });
      })
  }

  getExpectedStudents() {
    axios.get("http://localhost:4000/api/students") //Have to change endpoint in the future
      .then(result => {
        console.log("result", result.data)
        for (var i = 0; i < result.data.length; i++) {
          this.state.students.push(result.data[i].email_address);
        }
        console.log("students", this.state.students)
        this.setState({
          isLoaded: false,
        });
      })
      .catch(error => {
        this.setState({
          isLoaded: false,
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
          <ul>
            {this.state.students}
          </ul>
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
  }
}


export default home;