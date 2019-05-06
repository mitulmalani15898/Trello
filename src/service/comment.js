import axios from 'axios';

export default {
  postComment(comment) {
    return axios.post('api/comment', comment);
  },
  patchComment(commentId, data) {
    return axios.patch('api/comment/' + commentId, data);
  },
  deleteComment(commentId) {
    return axios.delete('api/comment/' + commentId);
  }
}