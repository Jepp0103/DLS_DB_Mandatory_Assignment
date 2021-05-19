import axios from "axios";
import React, { Component } from "react";
import $ from "jquery";
import {BrowserRouter as Router, useParams} from "react-router-dom";
import studentHome from "../pages/studentHome.js";
import publicIp from "public-ip";
 
class MyLecture extends Component {
  constructor(props) {
    super(props);
   // console.dir(props);      
    this.state = {
		isLoaded: false,
		lectureid: props.match.params.id,
		classLoaded: false,
		formLoaded: false,
		latitude: null,
		longitude: null,
		ip:null,
		currentLecture: ""
    }

  }


	componentDidMount() {	
		this.getClasses();
        this.getLecture();
		this.beginRegistration();
		this.setPosition();
		this.setIp();
		

	}
	componentDidUpdate(prevProps, prevState, snapshot) {
		if (this.props.match.params.id!== prevProps.match.params.id) {
			
			this.state.lectureid=this.props.match.params.id;
			this.getLecture();
		
		}
	}
	 setPosition() {
        window.navigator.geolocation.getCurrentPosition(
            success => this.setState({ latitude: success.coords.latitude.toFixed(8), longitude: success.coords.longitude.toFixed(8) })
        );
		
	}
	setIp(){
		const publicIp = require('public-ip');
		(async () => {
			this.setState({ip: await publicIp.v4()});

		})();
	}
	getClasses() {		
        axios.get("http://localhost:4000/api/myclasses")
            .then(result => {	
				this.state.classes=result.data;
				console.log(this.state.classes);
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

   getLecture() {

	   let data = { "lectureid": this.state.lectureid };
         axios.post("http://localhost:4000/api/getlecture", data)
            .then(result => {
                this.state.currentLecture = result.data;
				
				console.log(result.data.teachers[0].forename);
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
        $(".regAttButton").click(() => {
            let registrationInput = {
                "lectureid": this.state.currentLecture.id,
                "code": $("#lectureRegCodeInput").val(),
				"studentSSID": "KEANET",
				"ipaddress": this.state.ip,
				"teachingnetworkid":this.state.classes.faculty.networks[0].id,
				"latitude":this.state.latitude,
				"longitude":this.state.longitude,
				"teacherid":this.state.currentLecture.teachers[0].id,
				"facultyid":1

				
            };
            let isNum = /^\d+$/.test(this.state.currentLecture.id); //Validating if lecture id input is a number
            if (this.state.currentLecture.id != "" && isNum && $("#lectureRegCodeInput").val() != "") {
                axios.post("http://localhost:4000/api/registerattendence", registrationInput)
                    .then(result => {
                        $("#lectureRegIdInput").val("");
						if(result.data=="Registration successful"){
							alert("Register code for lecture succesfully added");
						}else{
							alert("Registration failed");
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
            } else {
                alert("Invalid input for lecture id or register code");
            }
        });
    }
  render() { 
	let lechtml;
	if(this.state.isLoaded && this.state.classLoaded){
		lechtml=<div>
				<div class="row">
					<div class="col3">
						<b>Course</b>
						<p> {this.state.currentLecture.course.name} </p>
					</div>
					<div class="col3">
						<b>Name:</b> 
						<p> {this.state.currentLecture.name}</p>
					</div>
					<div class="col3"> 
						<b>Date:</b>
						<p>{this.state.currentLecture.date}</p>
					</div>
				</div>	
				<div class="row">
					<div class="col2">
						<b>Teachers</b>
						<p>{this.state.currentLecture.teachers[0].forename+" "+this.state.currentLecture.teachers[0].surname}</p>
					</div>	
					<div class="col2 network" >
						<div class="latitude">	
							<b>Latitude</b>
							<p>{this.state.latitude}</p>	
						</div>	
						<div class="longitude">	
							<b>Longitude</b>
							<p>{this.state.longitude}</p>
						</div>	
						<div class="ip">	
							<b>IP</b>
							<p>{this.state.ip}</p>
						</div>	

					</div>				
				</div>
			 </div>;
	}
    return (
	<div class="container">	
        {lechtml}
		<div class="row">
			<div class="col1 codeinput">
				<b>Time left:</b>
				<p>placeholder</p>
				<div>
					<input type="text" id="lectureRegCodeInput" placeholder="Code" />
				</div>
				<div>
					<button class="regAttButton">Register attendance</button>
				</div>	
			</div>	
		</div>	
	</div>	



	
    );
	
  }
}
export default MyLecture;