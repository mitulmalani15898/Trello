import cardService from "../service/card";

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
      cardService
        .postCard(card)
        .then(res => {
          commit("setCard", res.data);
          dispatch("board/getBoardById", card.boardId, { root: true });
        })
        .catch(err => err.response.data.error);
    },
    patchCard({ dispatch }, cardData) {
      cardService
        .patchCard(cardData.cardId, cardData.change)
        .then(() => {
          dispatch("card/getCardById", cardData.cardId, { root: true });
          dispatch("board/getBoardById", cardData.boardId, { root: true });
        })
        .catch(err => err);
    },
    getCardById({ commit }, cardId) {
      cardService
        .getCardById(cardId)
        .then(res => {
          commit("setCard", res.data);
        })
        .catch(err => err.response.data.error);
    }
  }
};

export default card;
