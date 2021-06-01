import axios from "axios";
import React, { Component } from "react";
import $ from "jquery";
import {BrowserRouter as Router, useParams} from "react-router-dom";
import studentHome from "../pages/studentHome.js";
import teacherHome from "../pages/teacherHome.js";
import publicIp from "public-ip";
import Countdown, { zeroPad } from 'react-countdown';

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
		currentLecture: "",
		attendingStudents: [],
		lectureParticipationRate: null, 
		deadline:null
		
    }

  }


	componentDidMount() {
		this.getClasses();
        this.getLecture();
		this.setPosition();
		

	}
	componentDidUpdate(prevProps, prevState, snapshot) {
		if (this.props.match.params.id!== prevProps.match.params.id) {
			this.setState({lectureid: this.props.match.params.id});
			this.getLecture();
		
		}
	}
	 setPosition() {
        window.navigator.geolocation.getCurrentPosition(
            success => this.setState({ latitude: success.coords.latitude.toFixed(8), longitude: success.coords.longitude.toFixed(8) })
        );
		
	}
	setIp(){
		if (localStorage.getItem("role")=="student"){
			const publicIp = require('public-ip');
			(async () => {
				this.setState({ip: await publicIp.v4()});

			})();
		}
		else if(localStorage.getItem("role")=="teacher"){
			let ips="";
			this.state.currentLecture.classes.forEach(function(thisclass) {
				thisclass.faculty.networks.forEach(function(network) {
					if (!ips.includes(network.ip_address)){
						ips+=network.ip_address+" "
					}
				});
			});
			this.setState({ip: ips});
			
		}
		
	}
	getClasses() {		
        axios.get("https://rollcallapp.azurewebsites.net/api/myclasses")
            .then(result => {	
				this.setState({
                    classLoaded: true,
					classes:result.data,
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
         axios.post("https://rollcallapp.azurewebsites.net/api/getlecture", data)
            .then(result => {
				console.log(result.data);
				var loaded=false;
				const renderer = ({ hours, minutes, seconds, completed }) => {
				  if (completed) {
					return <span>Registration ended</span>;
				  } else {
					 if(!loaded && (zeroPad(seconds) % 10 == 0 || (seconds  == 1 && minutes == 0))){
						this.getAttendingStudents();
						loaded=true;
					 }else if (seconds.toString()[1]=='9'){loaded=false;}
					return <span>{zeroPad(minutes)}:{zeroPad(seconds)}</span>;
				  }
				};
				this.setState({
                    isLoaded: true,
					currentLecture : result.data,
					deadline: result.data.registrationdeadline,
					renderer: renderer
                });
				this.setIp();
				$("#teacherCodeInput").val(result.data.code);
            })
            .catch(error => {
                this.setState({
                    isLoaded: false,
                    error
                });
			})
    }
	registerAttendence(e) {
		let registrationInput = {
			"lectureid": this.state.currentLecture.id,
			"code": $("#lectureRegCodeInput").val(),
			"ipaddress": this.state.ip,
			"teachingnetworkid":this.state.classes.faculty.networks[0].id,
			"latitude":this.state.latitude,
			"longitude":this.state.longitude,
			"teacherid":this.state.currentLecture.teachers[0].id,

			
		};
		let isNum = /^\d+$/.test(this.state.currentLecture.id); //Validating if lecture id input is a number
		if (this.state.currentLecture.id != "" && isNum && $("#lectureRegCodeInput").val() != "") {
			axios.post("https://rollcallapp.azurewebsites.net/api/registerattendence", registrationInput)
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
	}
	  getAttendingStudents(e) {
		  let lectureId = { "id": this.state.currentLecture.id };
		  if (lectureId !== null) {
			axios.post("https://rollcallapp.azurewebsites.net/api/lectureattendence", lectureId) //Have to change endpoint in the future
			  .then(result => {
				this.state.attendingStudents = []; //Emptying array before inserting again
				for (var i = 0; i < result.data.length; i++) {
				  this.state.attendingStudents=result.data;
				}

				this.getLectureParticipationRate(lectureId);

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

		$("#hideStudentsBtn").click(() => {
		  $("#attStudentsUL").empty();
		  $("#lectureParticipationRateTag").empty();
		});
	  }
	getLectureParticipationRate(lectureId) {
		axios.post("https://rollcallapp.azurewebsites.net/api/lectureparticipationrate", lectureId)
		  .then(result => {
			console.log("lecture participation rate data: ", result.data)
			this.state.lectureParticipationRate = result.data
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
	beginRegistration(e) {
		if ($("#teacherCodeInput").val()==""){
			$("#teacherCodeInput").val(this.generateCode());
		}
		var minutesinput=$("#minutes").val()*60000;
		let newDate = new Date(Date.now()+minutesinput);
		let date = newDate.getDate();
		let month = newDate.getMonth() + 1;
		let hours = newDate.getHours();
		let minutes = newDate.getMinutes();
		let seconds = newDate.getSeconds();
		let year = newDate.getFullYear();
		var datetime=`${year}-${month<10?`0${month}`:`${month}`}-${date<10?`0${date}`:`${date}`} ${hours<10?`0${hours}`:`${hours}`}:${minutes<10?`0${minutes}`:`${minutes}`}:${seconds<10?`0${seconds}`:`${seconds}`}`;
		
		let registrationInput = {
			"id": this.state.currentLecture.id,
			"code": $("#teacherCodeInput").val(),
			"registrationdeadline": datetime
		};
		let isNum = /^\d+$/.test(this.state.currentLecture.id); //Validating if lecture id input is a number
		if (this.state.currentLecture.id != "" && isNum && $("#teacherCodeInput").val() != "") {
			axios.put("https://rollcallapp.azurewebsites.net/api/beginregistration", registrationInput)
			  .then(result => {
				alert("Register code for lecture succesfully added");
				this.setState({
				  deadline:newDate,
				  isLoaded: true,
				});
				let data = { "longitude": this.state.longitude,"latitude": this.state.latitude };
				axios.post("https://rollcallapp.azurewebsites.net/api/updateteachercoordinates", data)
				.then(result => {
					console.log("updated gps");
				})
				.catch(error => {
					console.log(error);
					this.setState({
					});
				})
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

	}
	generateCode() {
		var result           = [];
		var characters       = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
		var charactersLength = characters.length;
		for ( var i = 0; i < 5; i++ ) {
		  result.push(characters.charAt(Math.floor(Math.random() * charactersLength)));
	   }
	   return result.join('');
}
  render() { 
	let lechtml;
	let codehtml;
	let attendencehtml;
	if(this.state.isLoaded && this.state.classLoaded){
		lechtml=
			<div>
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
			 </div>
			 ;
		if (localStorage.getItem("role")=="student"){
			codehtml=			
				<div class="row">
					<div class="col1 codeinput">
						<b>Time left:</b>
						<p><Countdown
								date={this.state.deadline}
								renderer={this.state.renderer}
							/>
						</p>
						<div>
							<span>
								<input type="text" id="lectureRegCodeInput" placeholder="Code" />
							</span>
						</div>
						<div>
							<button onClick={this.registerAttendence.bind(this)} class="regAttButton">Register attendance</button>
						</div>	
					</div>	
				</div>;
		}else if (localStorage.getItem("role")=="teacher"){
			codehtml=			
				<div class="row">
					<div class="col1 codeinput">
						<b>Time left:</b>
						<p><Countdown
								date={this.state.deadline}
								renderer={this.state.renderer}
							/>
						</p>
						<div>						
							<input required type="text" id="teacherCodeInput" placeholder="Code" />
							<br/>
							<label for="quantity">Minutes:</label>
							<br/>
							<input type="number" id="minutes" name="minutes" min="1"/>
							<br/>
							<label for="checkNetwork">Check for network</label>
							<input defaultChecked type="checkbox" id="checkNetwork" name="checkNetwork"/>
						</div>
						<div>
							<button onClick={this.beginRegistration.bind(this)} class="startRegistration">Start registration</button>
						</div>	
					</div>	
				</div>;
				attendencehtml=
				<div class="row attendence">
					<div class="col1">
						<b>Attendence rate: {this.state.lectureParticipationRate}</b>
						<div>
							<button onClick={this.getAttendingStudents.bind(this)}>View list</button>
						</div>
						<div id="attendingStudents">
						{this.state.attendingStudents.map(attendee => (
							<div>{attendee.forename} {attendee.surname} {attendee.is_attending}</div>
						))}
						</div>
					</div>	
				</div>;
		}
		
				
	}
    return (
	<div class="container">	
        {lechtml}
		{codehtml}
		{attendencehtml}
	</div>	



	
    );
	
  }
}
export default MyLecture;