import axios from "axios";

export default {
  register(user) {
    return axios.post("auth/signup", user);
  },

  login(loginData) {
    return axios.post("auth/login", loginData);
  }
};
