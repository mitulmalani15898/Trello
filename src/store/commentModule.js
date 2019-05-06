import commentService from '../service/comment'

const comment = {
  namespaced: true,
  state: {
    comment: []
  },
  mutations: {
    setComment(state, comment) {
      state.comment = comment;
    }
  },
  actions: {
    postComment({ dispatch, commit }, comment) {
      commentService.postComment(comment)
        .then(res => {
          commit('setComment', res.data);
          dispatch('card/getCardById', comment.cardId, { root: true });
          dispatch("board/getBoardById", comment.boardId, { root: true });
        })
        .catch(err => console.log(err))
    },
    patchComment({ dispatch }, commentData) {
      commentService.patchComment(commentData.commentId, commentData.change)
        .then(res => {
          dispatch('card/getCardById', commentData.cardId, { root: true });
          dispatch("board/getBoardById", commentData.boardId, { root: true });
        })
        .catch(err => console.log(err))
    },
    deleteComment({ dispatch }, commentData) {
      commentService.deleteComment(commentData.commentId)
        .then(res => {
          dispatch('card/getCardById', commentData.cardId, { root: true });
          dispatch("board/getBoardById", commentData.boardId, { root: true });
        })
        .catch(err => console.log(err))
    }
  }
}

export default comment;