import listService from '../service/list'

const list = {
  namespaced: true,
  state: {
    list: []
  },
  mutations: {
    setList(state, list) {
      state.list = list;
    }
  },
  actions: {
    postList({ dispatch, commit }, list) {
      listService.postList(list)
        .then(res => {
          commit('setList', res.data);
          dispatch("board/getBoardById", list.boardId, { root: true });
        })
        .catch(err => err.response.data.error)
    }
  }
}

export default list;