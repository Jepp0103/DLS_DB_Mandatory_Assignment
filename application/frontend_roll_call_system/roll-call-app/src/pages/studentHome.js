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
            myLectures: [],
            attendingStudents: [],
			myStats: null,
            lectureParticipationRate: "",
			classLoaded: false,
            lecturesLoaded: false,
			statsLoaded: false,

        }
    }

    componentDidMount() {
        this.getClasses();
        this.getMyLectures();
        this.getCurrentLectures();
        this.getAttendingStudents();
		this.getMyStats();
    }

    getClasses() {		
        axios.get("http://localhost:4000/api/myclasses")
            .then(result => {	
				this.state.classes=result.data;
				
				this.setState({
                    classLoaded: true,
                });
             
            })
            .catch(error => {
				console.log(error);
                this.setState({
                    classLoaded: false,
                });
            })
    }

    getCurrentLectures() {		

        axios.get("http://localhost:4000/api/currentlectures")
            .then(result => {

              //  $("#currentLectureDiv").html(html);
                this.state.currentLectures=result.data;
				console.log(this.state.currentLectures);
				this.setState({
                    lecturesLoaded: true,
                });
            })
            .catch(error => {
				console.log(error);
                this.setState({
                    lecturesLoaded: true,
                    error
                });
            });
    }

    getMyLectures() {
        $("#getMyLecturesBtn").click(() => {
            axios.get("http://localhost:4000/api/mylectures")
                .then(result => {
                    for (var i = 0; i < result.data.length; i++) {
                        this.state.myLectures.push("(Lecture id: " + result.data[i].id +
                            ", lecture name: " + result.data[i].name +
                            ", course: " + result.data[i].course.name + "), ");
                    }
                    $("#myLecturesUl").html(this.state.mylectures);            
                })
                .catch(error => {
					console.log(error);
                });
        });
        $("#hideMyLecturesBtn").click(() => {
            $("#myLecturesUl").empty();
            this.state.mylectures = [];
        });
    }
	getMyStats() {		
        axios.get("http://localhost:4000/api/mystats")
            .then(result => {
                this.state.myStats=result.data;
				console.log(this.state.myStats);
				this.setState({
                    statsLoaded: true,
                });
            })
            .catch(error => {
				console.log(error);
                this.setState({
                    statsLoaded: false,
                });
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

                    
                    })
                    .catch(error => {
						console.log(error);

                    })
            }
        });

        $("#hideStudentsBtn").click(() => {alert();
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
        const { error, isLoaded,lecturesLoaded,classLoaded,statsLoaded } = this.state;
		
		if (lecturesLoaded && classLoaded && statsLoaded){
        return (
            <div id="homeStudentRollCall" class="container">

                <h1>School roll call student</h1>
				<Router>

				<div class="row">
					<div id="classDiv" class="col3">
						<b>My class:</b>
						<p>
							{this.state.classes.name}
						</p>
						<p>
							{this.state.classes.faculty.name}
						</p>
					</div>
					<div id="currentLectureDiv" class="col3">
								<b>Active lectures:</b><br/>
										
									{this.state.currentLectures.map(lecture => (
										<div>
										<Link 
										  to={{
											pathname: `/currentlectures/${lecture.id}`, 
											query:{id: `${lecture.id}`}
										  }}>
										  {lecture.name}
										</Link>
										</div>
										
									))}
																	

					</div >
					<div id="gpsDiv" class="col3">
						<b>GPS:</b>
					</div  >
				</div>
					<Switch>
						<Route exact path="/currentlectures/:id" component={MyLecture}/>
					</Switch>
				</Router>
				<div class="row">
					<div class="col1">
						<b>My stats:</b>
						<div class="participationrate">
							<p>You have participated in {this.state.myStats.participationrate}% of your assigned lectures</p>
						</div>
						<div class="courseparticipation">
						{this.state.myStats.courseparticipationrates.map(course => (
							<p> 
								{course.name}:{course.participationrate}%	
							</p>
						))}
						</div>
	
					</div>
				</div>

				<a id="logout"
					 href="#!"
					onClick={this.handleLogout}
					className="d-b td-n pY-5 bgcH-grey-100 c-grey-700">
					<i className="ti-power-off mR-10"></i>
					<span>Logout</span>
				</a>

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