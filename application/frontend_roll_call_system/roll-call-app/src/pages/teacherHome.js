import React, { Component } from "react";
import "../css/teacherHome.css";
import axios from "axios";
import $ from "jquery";
import {
    BrowserRouter as Router,
    Switch,
    Route,
    Link,
    useParams
} from "react-router-dom";
import MyLecture from "../pages/MyLecture.js";


class teacherHome extends Component {
  constructor(props) {
    super(props);
    this.state = {
      isLoaded: false,
	  classesLoaded: false,
	  lecturesLoaded: false,
	  currentLecturesLoaded: false,
      classes: [],
      currentLectures: [],
      mylectures: [],
    }
  }

  componentDidMount() {
    this.getClasses();
    this.getMyLectures();
    this.getCurrentLectures();
    this.beginRegistration();
  }

  getClasses() {
    axios.get("http://localhost:4000/api/myclasses")
      .then(result => {
        console.log("classes", result.data)
        this.setState({
		  classes:result.data,
          classesLoaded: true,
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
        this.setState({
		  currentLectures:result.data,
          currentLecturesLoaded: true,
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
    $("#getMyLecturesBtn").click(() => {
      axios.get("http://localhost:4000/api/mylectures") //Have to change endpoint in the future
        .then(result => {
          this.setState({
			mylectures:result.data,
            lecturesLoaded: true,
          });
        })
        .catch(error => {
          this.setState({
            isLoaded: false,
            error
          });
        });
    });
    $("#hideMyLecturesBtn").click(() => {
      $("#myLecturesUl").empty();
      this.state.mylectures = [];
    });
  }


  beginRegistration() {
    $("#openAttButton").click(() => {

      let registrationInput = {
        "id": $("#lectureRegIdInput").val(),
        "code": $("#lectureRegCodeInput").val(),
      };
      let isNum = /^\d+$/.test($("#lectureRegIdInput").val()); //Validating if lecture id input is a number
      if ($("#lectureRegIdInput").val() != "" && isNum && $("#lectureRegCodeInput").val() != "") {
        axios.post("http://localhost:4000/api/beginregistration", registrationInput)
          .then(result => {
            $("#lectureRegIdInput").val("");
            $("#lectureRegCodeInput").val("");
            alert("Register code for lecture succesfully added");
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
      } else {
        alert("Invalid input for lecture id or register code");
      }
    });
  }

  handleLogout() {
    localStorage.clear();
    window.location.href = "/";
  }

  render() {
    const { error, isLoaded, classesLoaded, lecturesLoaded, currentLecturesLoaded, classes } = this.state;
	let html;
	if (classesLoaded && currentLecturesLoaded){	
    return (
      <div id="homeTeacherRollCall" class="container">
        <h1>School roll call teacher</h1>
			<Router>
				<div class="row">
					<div class="col3">
						<b>My classes</b>
						{this.state.classes.map(classs => (
							<p> 
								{classs.classname}:{classs.coursename}	
							</p>
						))}
					</div>
					<div id="currentLectureDiv" class="col3">
						<b>Active lectures:</b><br/>
								
							{this.state.currentLectures.map(lecture => (
								<div>
								<Link 
								  to={{
									pathname: `/teacherlecture/${lecture.id}`, 
									query:{id: `${lecture.id}`}
								  }}>
								  {lecture.name}
								</Link>
								</div>
								
							))}												
					</div >
					<div class="col3"> 
						<b>Date:</b>
						<p></p>
					</div>
				</div>
				<Switch>
					<Route exact path="/teacherlecture/:id" component={MyLecture}/>
				</Switch>
			</Router>
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
	else{return null;}
  }
}


export default teacherHome;