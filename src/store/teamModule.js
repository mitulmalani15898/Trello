import teamService from '../service/team'

const team = {
  namespaced: true,
  state: {
    teams: [],
    userTeams: []
  },
  mutations: {
    setTeams(state, teams) {
      state.teams = teams;
    },
    setUserTeams(state, userTeams) {
      state.userTeams = userTeams;
    }
  },
  actions: {
    postTeam({ dispatch, commit }, team) {
      teamService.postTeam(team)
        .then(res => {
          commit('setTeams', res.data)
          dispatch('getTeamsByUserId', team.userId)
        })
        .catch(err => err.response.data.error)
    },
    getTeamsByUserId({ commit }, userId) {
      teamService.getTeamsByUserId(userId)
        .then(res => commit('setUserTeams', res.data))
        .catch(err => err.response.data.error)
    }
  }
}

export default team;