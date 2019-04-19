import axios from 'axios';

export default {
  postList(list) {
    return axios.post('api/list', list);
  },
  patchList(listId, data) {
    return axios.patch('api/list/' + listId, data);
  }
}