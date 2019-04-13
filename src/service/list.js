import axios from 'axios';

export default {
  postList(list) {
    return axios.post('api/list', list);
  }
}