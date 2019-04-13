<template>
  <div class="navItems">
    <div>
      <p style="margin-left:30px; margin-bottom:10px;">
        <b>Links</b>
      </p>
      <ul class="ul">
        <li class="li">
          <button class="anchorNav" @click="boardDialog = !boardDialog">Create a Board</button>
        </li>
      </ul>
      <hr>
      <br>
      <ul class="ul">
        <li class="li">
          <button class="anchorNav">Boards</button>
        </li>
        <li class="li">
          <button class="anchorNav">Home</button>
        </li>
      </ul>
      <hr>
      <br>
      <p style="margin-left:30px; margin-bottom:10px;">
        <b>Teams</b>
      </p>
      <ul class="ul">
        <li class="li">
          <button class="anchorNav" @click="teamDialog = !teamDialog">Create a Team</button>
        </li>
      </ul>
    </div>
    <AddBoard :dialog="boardDialog" v-on:updateBoardDialog="updateBoardDialog"/>
    <AddTeam :dialog="teamDialog" @updateTeamDialog="updateTeamDialog"/>
  </div>
</template>

<script>
import AddBoard from "./AddBoard.vue";
import AddTeam from "./AddTeam.vue";

export default {
  data() {
    return {
      boardDialog: false,
      teamDialog: false
    };
  },
  components: {
    AddBoard,
    AddTeam
  },
  methods: {
    updateBoardDialog(val) {
      this.boardDialog = val;
    },
    updateTeamDialog(val) {
      this.teamDialog = val;
    }
  }
};
</script>

<style>
.navItems {
  position: fixed;
  width: 210px;
  margin-top: 7%;
  margin-left: 15%;
  display: flex;
}
.anchorNav {
  width: 180px;
  background-color: transparent;
  border-radius: 4px;
  color: gray;
  display: flex;
  font-weight: 700;
  min-height: 20px;
  padding: 6px 8px 6px 15px;
  transition-property: background-color, border-color, box-shadow;
}
.anchorNav:hover {
  background-color: #e4f0f6;
  color: #026aa7;
}
.ul {
  list-style-type: none;
  margin-bottom: 12px;
}
.li {
  margin-bottom: 4px;
}
</style>

