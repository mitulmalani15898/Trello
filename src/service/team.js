import axios from "axios";

export default {
  postTeam(team) {
    return axios.post("api/team", team);
  },
  getTeamsByUserId(userId) {
    return axios.get("api/team/user/" + userId);
  }
};
