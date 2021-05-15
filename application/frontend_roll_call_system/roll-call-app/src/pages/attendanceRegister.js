import React, { Component } from "react";
import "./css/home.css";
import axios from "axios";
import $ from "jquery";



class attendanceRegister extends Component {
  constructor(props) {
    super(props);
    this.state = {
      isLoaded: false,

    }
  }

  componentDidMount() {

  }

  render() {
    const { error, isLoaded, classes } = this.state;
    return (
    
    );
  }
}


export default attendanceRegister;