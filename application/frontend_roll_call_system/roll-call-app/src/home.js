import React, { Component } from "react";
import styled from 'styled-components';

const OverAllView = styled.View`
    background-color: green;
    width: 100%;
    height: 100%;
`;

const CurrentClassesBox = styled.Text`
    font-size: 12px;
    align-self: flex-end;
    color: white;
    margin-right: 5%;
    font-weight: bold;
`;

class home extends Component {
  handleLogout() {
    localStorage.clear();
    window.location.href = "/";
  }

  render() {
    return (
      <OverAllView>

        <CurrentClassesBox>Hello</CurrentClassesBox>
      </OverAllView>

      //   <div>
      //     <h1>Hi there</h1>

      //     <a
      //       href="javascript:void(0);"
      //       onClick={this.handleLogout}
      //       className="d-b td-n pY-5 bgcH-grey-100 c-grey-700">
      //       <i className="ti-power-off mR-10"></i>
      //       <span style={{ color: "white" }}>Logout</span>
      //     </a>
      //   </div>
    );
  }
}
export default home;