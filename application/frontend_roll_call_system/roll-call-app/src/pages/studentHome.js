import React, { Component } from "react";
import {
    BrowserRouter as Router,
    Switch,
    Route,
    Link,
    useParams
} from "react-router-dom";
import "../css/studentHome.css";
import axios from "axios";
import $ from "jquery";
import MyLecture from "../pages/MyLecture.js";




class studentHome extends Component {
    constructor(props) {
        super(props);
        this.state = {
            isLoaded: false,
            classes: "",
            currentLectures: [],
            mylectures: [],
            attendingStudents: [],
            lectureParticipationRate: "",
        }
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
                console.log("classes", result.data)
                    this.state.classes=result.data.name;
                
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
        axios.get("http://localhost:4000/api/currentlectures")
            .then(result => {
                for (var i = 0; i < result.data.length; i++) {
                    //lectures += '<li><Link to = "/' + result.data[i].id + '">Link</Link></li>';
                }
              //  $("#currentLectureDiv").html(html);
                this.state.currentLectures=result;
				this.setState({
                    isLoaded: true,
                });
            })
            .catch(error => {
                this.setState({
                    isLoaded: false,
                    error
                });
            });
    }

    getMyLectures() {
        $("#getMyLecturesBtn").click(() => {
            axios.get("http://localhost:4000/api/mylectures")
                .then(result => {
                    for (var i = 0; i < result.data.length; i++) {
                        this.state.mylectures.push("(Lecture id: " + result.data[i].id +
                            ", lecture name: " + result.data[i].name +
                            ", course: " + result.data[i].course.name + "), ");
                    }
                    $("#myLecturesUl").html(this.state.mylectures);
                    this.setState({
                        isLoaded: false,
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

    getAttendingStudents() {
        $("#getStudentsBtn").click(() => {
            let lectureIdInput = { "lectureid": $("#lectureIdInput").val() };
            if (lectureIdInput !== null) {
                axios.post("http://localhost:4000/api/lectureattendence", lectureIdInput) //Have to change endpoint in the future
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

        $("#hideStudentsBtn").click(() => {
            $("#attStudentsUL").empty();
            $("#lectureParticipationRateTag").empty();
        });
    }

    getLectureParticipationRate(lectureId) {
        axios.post("http://localhost:4000/api/lectureparticipationrate", lectureId)
            .then(result => {
                console.log("lecture participation rate data: ", result.data)
                this.state.lectureParticipationRate = result.data
                $("#lectureParticipationRateTag").text(this.state.lectureParticipationRate + " % attendance");

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
		if (isLoaded){
        return (
            <div id="homeStudentRollCall" class="container">
			<Router>

                <h1>School roll call student</h1>
				<div class="row">
					<div id="classDiv" class="col3">
						<b>My class:</b>
						<p>
							{this.state.classes}
						</p>
					</div>
					<div id="currentLectureDiv" class="col3">
							<React.Fragment>
								<b>Active lectures:</b><br/>
										
									{this.state.currentLectures.data.map(lecture => (
										<Link 
										  to={{
											pathname: `/currentlectures/${lecture.id}`, 
											query:{id: `${lecture.id}`, name: `${lecture.name}`}
										  }}>
										  {lecture.name}
										</Link>	
										
									))}
																	

							</React.Fragment>
					</div >
					<div id="gpsDiv" class="col3">
						<b>GPS:</b>
					</div  >
				</div>
			
				<Switch>
					<Route path="/currentlectures/:id" component={MyLecture}/>
				</Switch>
				<a id="logout"
                    href="#!"
                    onClick={this.handleLogout}
                    className="d-b td-n pY-5 bgcH-grey-100 c-grey-700">
                    <i className="ti-power-off mR-10"></i>
                    <span>Logout</span>
                </a>
			</Router>

            </div >
					/*<div id="attendingStudentsDiv" class="col3">
						<b>Attending students for specific lecture:</b>
						<input type="text" id="lectureIdInput" placeholder="Write id of lecture" />
						<button id="getStudentsBtn">Get students</button>
						<button id="hideStudentsBtn">Hide students</button>
						<br></br>
						<b id="lectureParticipationRateTag"></b>
						<ul id="attStudentsUL">
						</ul>
					</div>
					                <div id="currentCourseDiv">
                    <b>Current course:</b>
                </div>
                <div id="networkDiv">
                    <b>Network:</b>
                </div>
                <div id="myLecturesDiv">
                    <b>All my lectures:</b>
                    <button id="getMyLecturesBtn">Show my lectures</button>
                    <button id="hideMyLecturesBtn">Hide my lectures</button>
                    <br></br>
                    <ul id="myLecturesUl">
                    </ul>
                </div>*/

			
        );
		}else{return "";}
    }
}




export default studentHome;