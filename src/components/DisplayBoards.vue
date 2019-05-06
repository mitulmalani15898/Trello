<template>
  <div class="allBoards">
    <AddBoard :dialog="boardDialog" v-on:updateBoardDialog="updateBoardDialog"/>
    <div style="position: sticky;">
      <div>
        <div class="boards-page-board-section">
          <div class="boards-page-board-section-header">
            <h3 class="boards-page-board-section-header-name">Personal Boards</h3>
          </div>
          <ul class="boards-page-board-section-list">
            <li
              v-for="board in privateBoards"
              :key="board.id"
              class="boards-page-board-section-list-item"
            >
              <button class="board-tile" @click="displayBoardView(board.id)">
                <span class="board-tile-fade"></span>
                <div class="board-tile-details">
                  <div class="board-tile-details-name">{{ board.boardName }}</div>
                </div>
              </button>
            </li>
            <li class="boards-page-board-section-list-item">
              <button class="board-tile" style="color:#696969;" @click="toggleBoardDialog">
                <span class="board-tile-fade" style="background-color:#D3D3D3"></span>
                <div class="board-tile-details">
                  <div class="board-tile-details-name">Create Board...</div>
                </div>
              </button>
            </li>
          </ul>
        </div>

        <div class="boards-page-board-section">
          <div v-for="team in teamBoards" :key="team.id">
            <div class="boards-page-board-section-header">
              <h3 class="boards-page-board-section-header-name">{{team.teamName}}</h3>
            </div>
            <ul class="boards-page-board-section-list">
              <li
                v-for="board in team['Boards']"
                :key="board.id"
                class="boards-page-board-section-list-item"
              >
                <button class="board-tile" @click="displayBoardView(board.id)">
                  <span class="board-tile-fade"></span>
                  <div class="board-tile-details">
                    <div class="board-tile-details-name">{{ board.boardName }}</div>
                  </div>
                </button>
              </li>
              <li class="boards-page-board-section-list-item">
                <button class="board-tile" style="color:#696969;" @click="toggleBoardDialog">
                  <span class="board-tile-fade" style="background-color:#D3D3D3"></span>
                  <div class="board-tile-details">
                    <div class="board-tile-details-name">Create Board...</div>
                  </div>
                </button>
              </li>
            </ul>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import AddBoard from "./AddBoard.vue";

export default {
  data() {
    return {
      boardDialog: false
    };
  },
  components: {
    AddBoard
  },
  beforeCreate() {
    let userId = localStorage.getItem("userId");
    if (userId) {
      this.$store.dispatch("user/getUserByUserId", userId);
      this.$store.dispatch("team/getTeamsByUserId", userId);
    }
  },
  computed: {
    privateBoards() {
      return this.$store.state.user.user.Boards;
    },
    teamBoards() {
      return this.$store.state.team.userTeams;
    }
  },
  methods: {
    toggleBoardDialog() {
      this.boardDialog = !this.boardDialog;
    },
    updateBoardDialog(val) {
      this.boardDialog = val;
    },
    displayBoardView(boardId) {
      this.$router.push({ path: "board/" + boardId });
    }
  }
};
</script>


<style>
.allBoards {
  width: 860px;
  overflow: hidden;
  margin-top: 6%;
  margin-left: 30%;
  display: inline-block;
}
.boards-page-board-section {
  margin: 0 auto;
  max-width: 1250px;
  padding: 20px 16px 0;
}
.boards-page-board-section-header {
  margin: 0 0 0 40px;
  padding: 0 0 11px;
  position: relative;
}
.boards-page-board-section-header-name {
  display: inline-block;
  line-height: 24px;
  margin: 4px 0 0;
  font-size: 16px;
  font-weight: 700;
}
.boards-page-board-section-list {
  display: flex;
  flex-wrap: wrap;
  list-style-type: none;
}
.boards-page-board-section-list-item {
  box-sizing: border-box;
  padding: 4px 8px;
  position: relative;
  width: 25%;
  cursor: pointer;
  width: 23.5%;
  margin: 0 2% 8px 0;
  -webkit-transform: translate(0);
  transform: translate(0);
}
.board-tile,
.board-tile-fade {
  border-radius: 3px;
  display: block;
  color: white;
  text-decoration: none;
}
.board-tile-fade {
  background-color: #1c72a3;
  bottom: 0;
  left: 0;
  position: absolute;
  right: 0;
  top: 0;
}
.board-tile-details {
  display: flex;
  height: 80px;
  position: relative;
  flex-direction: column;
  justify-content: space-between;
}
.board-tile-details-name {
  flex: 0 0 auto;
  font-size: 16px;
  font-weight: 700;
  display: inline-block;
  overflow: hidden;
  max-height: 40px;
  width: 100%;
  text-decoration: none;
  word-wrap: break-word;
}
</style>
