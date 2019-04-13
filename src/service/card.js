import axios from 'axios';

export default {
  postCard(card) {
    return axios.post('api/card', card);
  }
}