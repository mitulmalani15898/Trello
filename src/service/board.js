import axios from "axios";

export default {
  postBoard(board) {
    return axios.post("api/board", board);
  },
  getBoardById(boardId) {
    return axios.get("api/board/" + boardId);
  },
  patchBoard(boardId, boardData) {
    return axios.patch("api/board/" + boardId, boardData);
  }
};
