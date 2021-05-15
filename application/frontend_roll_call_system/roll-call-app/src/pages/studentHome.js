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




class studentHome extends Component {
    constructor(props) {
        super(props);
        this.state = {
            isLoaded: false,
            classes: [],
            currentLectures: [],
            mylectures: [],
            attendingStudents: [],
            lectureParticipationRate: ""
        }
    }

    componentDidMount() {
        this.getClasses();
        this.getMyLectures();
        this.getCurrentLectures();
        this.getAttendingStudents();
        this.beginRegistration();
    }

    getClasses() {
        axios.get("http://localhost:4000/api/myclasses")
            .then(result => {
                console.log("classes", result.data)
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
        axios.get("http://localhost:4000/api/currentlectures")
            .then(result => {
                let html = '<Router><React.Fragment><b>Active lectures:</b><ul id="currentLecturesUl">';
                for (var i = 0; i < result.data.length; i++) {
                    html += '<li><Link to = "/' + result.data[i].id + '">Link</Link></li>';
                }
                html += '</ul><Switch><Route path="/:id" component={Child}/></Switch></React.Fragment></Router>';
                alert(html)
                $("#currentLectureDiv").html(html);
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

    beginRegistration() {
        $("#regAttButton").click(() => {

            let registrationInput = {
                "id": $("#lectureRegIdInput").val(),
                "code": $("#lectureRegCodeInput").val()
            };
            console.log("registrationinput", registrationInput)
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
        const { error, isLoaded, classes } = this.state;
        let cr = this.getCurrentLectures();
        alert(cr)
        return (
            <div id="homeStudentRollCall">
                <h1>School roll call student</h1>
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
                    <button id="hideStudentsBtn">Hide students</button>
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
                <div id="currentLectureDiv">
                    {cr}
                    {/* <Router><React.Fragment><b>Active lectures:</b><ul id="currentLecturesUl"><li><Link to="/15">Link</Link></li></ul><Switch><Route path="/:id" component={Child} /></Switch></React.Fragment></Router> */}
                </div >
                <div>
                    <input type="text" id="lectureRegIdInput" placeholder="Active lecture id to register" />
                    <input type="text" id="lectureRegCodeInput" placeholder="Add register code" />
                </div>
                <div>
                    <button id="regAttButton">Register attendance</button>
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

const Child = ({ match }) => (
    // We can use the `useParams` hook here to access
    // the dynamic pieces of the URL.
    <div>
        <h3>ID: {match.params.id}​​​​​</h3>
    </div>
);



export default studentHome;