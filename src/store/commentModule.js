import commentService from "../service/comment";

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
      commentService
        .postComment(comment)
        .then(res => {
          commit("setComment", res.data);
          dispatch("card/getCardById", comment.cardId, { root: true });
          dispatch("board/getBoardById", comment.boardId, { root: true });
        })
        .catch(err => err);
    },
    patchComment({ dispatch }, commentData) {
      commentService
        .patchComment(commentData.commentId, commentData.change)
        .then(() => {
          dispatch("card/getCardById", commentData.cardId, { root: true });
          dispatch("board/getBoardById", commentData.boardId, { root: true });
        })
        .catch(err => err);
    },
    deleteComment({ dispatch }, commentData) {
      commentService
        .deleteComment(commentData.commentId)
        .then(() => {
          dispatch("card/getCardById", commentData.cardId, { root: true });
          dispatch("board/getBoardById", commentData.boardId, { root: true });
        })
        .catch(err => err);
    }
  }
};

export default comment;
