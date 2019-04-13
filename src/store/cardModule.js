import cardService from '../service/card'

const card = {
  namespaced: true,
  state: {
    card: []
  },
  mutations: {
    setCard(state, card) {
      state.card = card;
    }
  },
  actions: {
    postCard({ dispatch, commit }, card) {
      cardService.postCard(card)
        .then(res => {
          commit('setCard', res.data);
          dispatch("board/getBoardById", card.boardId, { root: true });
        })
        .catch(err => err.response.data.error)
    }
  }
}

export default card;