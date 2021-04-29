import React, { Component } from "react";
import styled from 'styled-components';


class home extends Component {
  handleLogout() {
    localStorage.clear();
    window.location.href = "/";
  }

  render() {
    return (

        <div>
          <h1>Hi there</h1>
          
          <a
            href="javascript:void(0);"
            onClick={this.handleLogout}
            className="d-b td-n pY-5 bgcH-grey-100 c-grey-700">
            <i className="ti-power-off mR-10"></i>
            <span style={{ color: "white" }}>Logout</span>
          </a>
        </div>
    );
  }
}
export default home;