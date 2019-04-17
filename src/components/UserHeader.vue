<template>
  <div>
    <v-toolbar dark class="toolbar">
      <v-btn icon class="btnBoard" @click="redirectToDashboard">
        <v-icon>mdi-home</v-icon>
      </v-btn>
      <v-btn flat class="btnBoard" @click="redirectToDashboard">
        <span>Boards</span>
      </v-btn>
      <input class="header-search-input" placeholder="Search...">
      <v-spacer></v-spacer>
      <img src="../../public/trello-logo-white.svg" alt="Trello" width="130px" height="28px">
      <v-spacer></v-spacer>
      <v-btn icon class="btnBoard">
        <v-menu bottom origin="center center">
          <template v-slot:activator="{ on }">
            <v-icon v-on="on">mdi-note-plus-outline</v-icon>
          </template>
          <v-list>
            <v-list-tile>
              <v-list-tile @click="boardDialog = !boardDialog">
                <v-list-tile-title>Create Board</v-list-tile-title>
              </v-list-tile>
            </v-list-tile>
            <v-list-tile>
              <v-list-tile @click="teamDialog = !teamDialog">
                <v-list-tile-title>Create Team</v-list-tile-title>
              </v-list-tile>
            </v-list-tile>
          </v-list>
        </v-menu>
      </v-btn>
      <v-btn icon class="btnBoard">
        <v-icon>mdi-information-outline</v-icon>
      </v-btn>
      <v-btn icon class="btnBoard">
        <v-icon>mdi-bell-outline</v-icon>
      </v-btn>
      <v-btn icon class="btnBoard">
        <v-menu bottom origin="center center">
          <template v-slot:activator="{ on }">
            <v-icon v-on="on">mdi-account-circle-outline</v-icon>
          </template>
          <v-list>
            <v-list-tile>
              <v-list-tile @click="logOut">
                <v-list-tile-title>Log Out</v-list-tile-title>
              </v-list-tile>
            </v-list-tile>
          </v-list>
        </v-menu>
      </v-btn>
    </v-toolbar>
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
    },
    logOut() {
      this.$store.dispatch("logOut");
    },
    redirectToDashboard() {
      this.$router.replace("/dashboard");
    }
  }
};
</script>

<style>
.toolbar {
  position: fixed;
  height: 45px;
  padding: 2px 15px !important;
  background-color: #026aa7 !important;
  z-index: 111;
}
.btnBoard {
  background-color: hsla(0, 0%, 100%, 0.2);
  height: 32px;
}
.header-search-input {
  background-color: hsla(0, 0%, 100%, 0.2);
  border-radius: 3px;
  border: none;
  box-shadow: none;
  color: hsla(0, 0%, 100%, 0.8);
  float: left;
  font-size: 13px;
  height: 32px;
  min-height: 32px;
  padding-left: 8px;
  width: 180px;
  z-index: 1;
}
</style>

