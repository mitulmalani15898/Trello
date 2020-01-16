import axios from "axios";

export default {
  postCard(card) {
    return axios.post("api/card", card);
  },
  patchCard(cardId, data) {
    return axios.patch("api/card/" + cardId, data);
  },
  getCardById(cardId) {
    return axios.get("api/card/" + cardId);
  }
};
