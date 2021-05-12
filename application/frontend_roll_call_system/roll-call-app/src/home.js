import React, { Component } from "react";
import styled from 'styled-components';
import "./css/home.css";
import axios from "axios";
import $ from "jquery";



class home extends Component {
  constructor(props) {
    super(props);
    this.state = {
      isLoaded: false,
      classes: [],
      currentLectures: [],
      mylectures: [],
      attendingStudents: [],
      lectureParticipationRate: ""
    };
  }

  componentDidMount() {
    this.getClasses();
    this.getMyLectures();
    this.getCurrentLectures();
    this.getAttendingStudents();
  }

  getClasses() {
    axios.get("http://localhost:4000/api/myclasses")
      .then(result => {
        for (var i = 0; i < result.data.length; i++) {
          this.state.classes.push(result.data[i].classname + ", ");
        }
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

  getCurrentLectures() {
    axios.get("http://localhost:4000/api/currentlectures") //Have to change endpoint in the future
      .then(result => {
        console.log("current lectures: ", result.data)
        for (var i = 0; i < result.data.length; i++) {
          this.state.currentLectures.push(result.data[i].name);
        }
        this.setState({
          isLoaded: true,
        });
      })
      .catch(error => {
        this.setState({
          isLoaded: false,
          error
        });
      })
  }

  getMyLectures() {
    axios.get("http://localhost:4000/api/mylectures") //Have to change endpoint in the future
      .then(result => {
        for (var i = 0; i < result.data.length; i++) {
          this.state.mylectures.push("(Lecture id: " + result.data[i].id +
            ", lecture name: " + result.data[i].name +
            ", course: " + result.data[i].course.name + "), ");
        }
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

  getAttendingStudents() {
    $("#getStudentsBtn").click(() => {
      let lectureIdInput = $("#lectureIdInput").val();
      if (lectureIdInput !== null) {
        axios.get("http://localhost:4000/api/lectureattendence?lectureid=" + lectureIdInput) //Have to change endpoint in the future
          .then(result => {
            this.state.attendingStudents = []; //Emptying array before inserting again
            for (var i = 0; i < result.data.length; i++) {
              this.state.attendingStudents.push(result.data[i].forename + " " + result.data[i].surname + ": " + result.data[i].is_attending + ", \n");
            }

            $("#attStudentsUL").html(this.state.attendingStudents);

            //Displaying participation rate for a lecture
            this.getLectureParticipationRate(lectureIdInput);

            this.setState({
              isLoaded: true,
            });
          })
          .catch(error => {
            this.setState({
              isLoaded: false,
              error
            });
          })
      }
    });
  }

  getLectureParticipationRate(lectureId) {
    axios.get("http://localhost:4000/api/lectureparticipationrate?lectureId=" + lectureId) //Have to change endpoint in the future
      .then(result => {
        console.log("lecture participation rate data: ", result.data)
        this.state.lectureParticipationRate = result.data
        $("#lectureParticipationRateTag").text(this.state.lectureParticipationRate + " %");

        this.setState({
          isLoaded: true,
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
        <div id="attendingStudentsDiv">
          <b>Attending students for specific lecture:</b>
          <input type="text" id="lectureIdInput" placeholder="Write id of lecture" />
          <button id="getStudentsBtn">Get students</button>
          <br></br>
          <b id="lectureParticipationRateTag"></b>
          <ul id="attStudentsUL">
          </ul>
        </div>
        <div id="gpsDiv">
          <b>GPS:</b>

        </div  >
        <div id="currentCourseDiv">
          <b>Current course:</b>

        </div>

        <div id="myLecturesDiv">
          <b>All my lectures:</b>
          <ul>
            {this.state.mylectures}
          </ul>

        </div>
        <div id="currentLectureDiv">
          <b>Active lectures:</b>
          <ul>
            {this.state.currentLectures}
          </ul>
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