import authService from "../service/auth";
import router from "../router";

export default {
  register({ commit, dispatch }, user) {
    return authService
      .register(user)
      .then(() => {
        dispatch("login", {
          email: user.email,
          password: user.password
        });
        commit("clearAuthError");
      })
      .catch(err => commit("setAuthError", err.response.data.error));
  },

  login({ commit }, loginData) {
    return authService
      .login(loginData)
      .then(res => {
        commit("authenticatedUser", {
          token: res.data.user.token,
          userName: res.data.user.name,
          userId: res.data.user.id
        });
        commit("clearAuthError");
        localStorage.setItem("token", res.data.user.token);
        localStorage.setItem("userName", res.data.user.name);
        localStorage.setItem("userId", res.data.user.id);
        router.replace("/dashboard");
      })
      .catch(err => commit("setAuthError", err.response.data.error));
  },

  logOut({ commit }) {
    commit("clearAuthData");
    localStorage.removeItem("token");
    localStorage.removeItem("userName");
    localStorage.removeItem("userId");
    router.replace("/login");
  }
};
