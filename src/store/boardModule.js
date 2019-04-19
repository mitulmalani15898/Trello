import boardService from '../service/board'

const board = {
  namespaced: true,
  state: {
    boards: [],
    selectedBoard: []
  },
  mutations: {
    setBoards(state, boards) {
      state.boards = boards;
    },
    setSelectedBoard(state, selectedBoard) {
      state.selectedBoard = selectedBoard;
    },
    setLists(state, lists) {
      state.selectedBoard.Lists = lists;
    }
  },
  actions: {
    postBoard({ dispatch, commit }, board) {
      boardService.postBoard(board)
        .then(res => {
          commit('setBoards', res.data);
          dispatch("user/getUserByUserId", board.userId, { root: true });
          dispatch("team/getTeamsByUserId", board.userId, { root: true });
        })
        .catch(err => err.response.data.error)
    },
    getBoardById({ commit }, boardId) {
      boardService.getBoardById(boardId)
        .then(res => commit('setSelectedBoard', res.data))
        .catch(err => console.log(err))
    },
    patchBoard({ dispatch }, boardData) {
      boardService.patchBoard(boardData.boardId, boardData.listId)
        .then(res => {
          dispatch("board/getBoardById", boardData.boardId, { root: true });
        })
        .catch(err => console.log(err))
    }
  }
}

export default board;