import axios from "axios";
import React, { Component } from "react";
import $ from "jquery";

class MyLecture extends Component {
  constructor(props) {
    super(props);
   // console.dir(props);      
    this.state = {
		fromIdeas: props.match.params.WORLD || 'unknown',
		isLoaded: false,
		lectureid: props.match.params.id,
		currentLecture: ""
    }
  }
	componentDidMount() {
        this.getLecture();
		this.beginRegistration();
	}
   getLecture() {
	   let data = { "lectureid": this.state.lectureid };
         axios.post("http://localhost:4000/api/getlecture", data)
            .then(result => {
                this.state.currentLecture = result.data;
				console.log(result.data.teachers[0]);
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
                "lectureid": this.state.currentLecture.id,
                "code": $("#lectureRegCodeInput").val(),
				"studentSSID": "KEANET",
				"ipaddress": "193.29.107.196",
				"teachingnetworkid":1,
				"latitude":55.70392118,
				"longitude":12.53752105,
				"teacherid":1,
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
    const { match, location} = this.props;
    return (
	<div class="container">	

		<div class="row">
			<div class="col3">
				<b>ID</b>
				<p> {this.state.currentLecture.id} </p>
			</div>
			<div class="col3">
				<b>Name:</b> 
				<p> {this.state.currentLecture.name}</p>
			</div>
			<div class="col3"> 
				<b>Time:</b>
				<p>{this.state.currentLecture.timeStart}</p>
			</div>
		</div>	
		<div class="row">
			<div class="col1">
				<div>
					<input type="text" id="lectureRegCodeInput" placeholder="Code" />
				</div>
				<div>
					<button id="regAttButton">Register attendance</button>
				</div>	
			</div>	
		</div>	
	</div>	



	
    );
  }
}
export default MyLecture;