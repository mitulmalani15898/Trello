export default {
  authenticatedUser(state, data) {
    (state.token = data.token),
      (state.userName = data.userName),
      (state.userId = data.userId);
  },

  clearAuthData(state) {
    (state.token = null),
      (state.userName = null),
      (state.userId = null),
      (state.authError = null);
  },

  setAuthError(state, err) {
    state.authError = err;
  },

  clearAuthError(state) {
    state.authError = null;
  }
};
