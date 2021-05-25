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
        axios.get("http://localhost:4000/api/myclasses")
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
         axios.post("http://localhost:4000/api/getlecture", data)
            .then(result => {
				this.state.b=false; 
				const renderer = ({ hours, minutes, seconds, completed }) => {
				  if (completed) {
					  if (this.state.b==false){
						this.state.b=true;
					  }
					return <span>Registration ended</span>;
				  } else {
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
		var datetime=`${year}-${month<10?`0${month}`:`${month}`}-${date} ${hours<10?`0${hours}`:`${hours}`}:${minutes<10?`0${minutes}`:`${minutes}`}:${seconds<10?`0${seconds}`:`${seconds}`}`;
		
		let registrationInput = {
			"id": this.state.currentLecture.id,
			"code": $("#teacherCodeInput").val(),
			"registrationdeadline": datetime
		};
		console.log(registrationInput);
		let isNum = /^\d+$/.test(this.state.currentLecture.id); //Validating if lecture id input is a number
		if (this.state.currentLecture.id != "" && isNum && $("#teacherCodeInput").val() != "") {
			axios.post("http://localhost:4000/api/beginregistration", registrationInput)
			  .then(result => {
				alert("Register code for lecture succesfully added");
				this.setState({
				  deadline:newDate,
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
		}
				
	}
    return (
	<div class="container">	
        {lechtml}
		{codehtml}
	</div>	



	
    );
	
  }
}
export default MyLecture;