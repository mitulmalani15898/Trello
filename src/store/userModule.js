import userService from "../service/user";

const user = {
  namespaced: true,
  state: {
    user: []
  },
  mutations: {
    setUser(state, user) {
      state.user = user;
    }
  },
  actions: {
    getUserByUserId({ commit }, userId) {
      userService
        .getUserByUserId(userId)
        .then(res => commit("setUser", res.data))
        .catch(err => err.response.data.error);
    }
  }
};

export default user;
