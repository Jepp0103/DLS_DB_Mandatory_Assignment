import axios from 'axios';

//export const jwtToken = localStorage.getItem("authorization");

axios.interceptors.request.use(
	config => {
	if (localStorage.getItem("authorization")) {
	  config.headers["authorization"] = "Bearer " + localStorage.getItem("authorization");
	}
	return config;
  },
  error => {
	return Promise.reject(error);
  }
);

