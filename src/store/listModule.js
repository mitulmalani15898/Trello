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
    },
    patchList({ dispatch }, listData) {
      listService.patchList(listData.listId, listData.list)
        .then(res => {
          dispatch("board/getBoardById", listData.boardId, { root: true });
        })
        .catch(err => console.log(err))
    }
  }
}

export default list;