<template>
  <div>
    <div class="boardHeader">
      <div class="text-xs-center">
        <v-menu v-model="menuBoardName" :close-on-content-click="false" :nudge-width="100" offset-x>
          <template v-slot:activator="{ on }">
            <div class="board-header-btn board-header-btn-name">
              <button class="board-header-btn-text" v-on="on">{{ boardName }}</button>
            </div>
          </template>
          <v-card>
            <v-form ref="boardName">
              <v-container grid-list-md>
                <v-layout row wrap>
                  <v-flex>
                    <v-text-field label="Board Title" v-model="boardName" outline></v-text-field>
                  </v-flex>
                </v-layout>
              </v-container>
              <v-card-actions>
                <v-spacer></v-spacer>
                <v-btn color="primary" flat @click="updateBoardName()">Update</v-btn>
                <v-btn color="primary" flat @click="menuBoardName = !menuBoardName">Cancel</v-btn>
              </v-card-actions>
            </v-form>
          </v-card>
        </v-menu>
      </div>
      <span class="board-header-btn-divider"></span>
      <div class="text-xs-center">
        <v-menu v-model="menuBoardTeam" :close-on-content-click="false" :nudge-width="100" offset-x>
          <template v-slot:activator="{ on }">
            <button class="board-header-btn board-header-btn-text" v-on="on">{{ boardTeam }}</button>
          </template>
          <v-card>
            <v-form ref="boardTeam">
              <v-container grid-list-md>
                <v-layout row wrap>
                  <v-flex>
                    <v-select :items="teamNames" v-model="boardTeam" label="Team" outline></v-select>
                  </v-flex>
                </v-layout>
              </v-container>
              <v-card-actions>
                <v-spacer></v-spacer>
                <v-btn color="primary" flat @click="updateBoardTeam()">Update</v-btn>
                <v-btn color="primary" flat @click="menuBoardTeam = !menuBoardTeam">Cancel</v-btn>
              </v-card-actions>
            </v-form>
          </v-card>
        </v-menu>
      </div>
      <span class="board-header-btn-divider"></span>
      <div class="text-xs-center">
        <v-menu
          v-model="menuBoardScope"
          :close-on-content-click="false"
          :nudge-width="100"
          offset-x
        >
          <template v-slot:activator="{ on }">
            <button class="board-header-btn board-header-btn-text" v-on="on">{{ boardScope }}</button>
          </template>
          <v-card>
            <v-form ref="boardScope">
              <v-container grid-list-md>
                <v-layout row wrap>
                  <v-flex>
                    <v-select :items="items" v-model="boardScope" label="Scope" outline></v-select>
                  </v-flex>
                </v-layout>
              </v-container>
              <v-card-actions>
                <v-spacer></v-spacer>
                <v-btn color="primary" flat @click="updateBoardScope()">Update</v-btn>
                <v-btn color="primary" flat @click="menuBoardScope = !menuBoardScope">Cancel</v-btn>
              </v-card-actions>
            </v-form>
          </v-card>
        </v-menu>
      </div>
    </div>
  </div>
</template>

<script>
import _ from "lodash";

export default {
  data() {
    return {
      menuBoardName: false,
      menuBoardTeam: false,
      menuBoardScope: false,
      name: "",
      team: "",
      scope: "",
      items: ["Private", "Public"]
    };
  },
  beforeCreate() {
    let userId = localStorage.getItem("userId");
    if (userId) {
      this.$store.dispatch("team/getTeamsByUserId", userId);
    }
  },
  computed: {
    selectedBoard() {
      return this.$store.state.board.selectedBoard;
    },
    boardName: {
      get: function() {
        return this.$store.state.board.selectedBoard.boardName;
      },
      set: function(newVal) {
        this.name = newVal;
      }
    },
    boardTeam: {
      get: function() {
        return this.$store.state.board.selectedBoard.teamId === 1
          ? "Personal"
          : this.getTeamNameById(this.$store.state.board.selectedBoard.teamId);
      },
      set: function(newVal) {
        this.team = newVal;
      }
    },
    boardScope: {
      get: function() {
        return this.$store.state.board.selectedBoard.scope === 1
          ? "Private"
          : "Public";
      },
      set: function(newVal) {
        this.scope = newVal;
      }
    },
    teamNames() {
      let teams = [];
      this.$store.state.team.userTeams.forEach(team => {
        teams.push({
          text: team.teamName,
          value: team.id
        });
      });
      teams.unshift("Personal");
      return teams;
    }
  },
  methods: {
    updateBoardName() {
      let boardId = this.selectedBoard.id;
      let boardData = {
        boardId,
        board: {
          boardName: this.name
        }
      };
      this.$store.dispatch("board/patchBoard", boardData);
      this.menuBoardName = false;
    },
    updateBoardTeam() {
      let boardId = this.selectedBoard.id;
      let teamId = this.team == "Personal" ? 1 : this.team;
      let boardData = {
        boardId,
        board: {
          teamId
        }
      };
      this.$store.dispatch("board/patchBoard", boardData);
      this.menuBoardTeam = false;
    },
    updateBoardScope() {
      let boardId = this.selectedBoard.id;
      const scope = this.scope === "Private" ? 1 : 0;
      let boardData = {
        boardId,
        board: {
          scope
        }
      };
      this.$store.dispatch("board/patchBoard", boardData);
      this.menuBoardScope = false;
    },
    getTeamNameById(teamId) {
      return _.result(_.find(this.teamNames, { value: teamId }), "text");
    }
  }
};
</script>


<style>
.boardHeader {
  top: 55px;
  height: 45px;
  width: 100%;
  padding: 8px 4px 8px 8px;
  position: fixed;
  z-index: 100;
  background-color: #026aa7 !important;
}
.board-header-btn {
  border-radius: 3px;
  color: #f6f6f6;
  float: left;
  font-size: 14px;
  height: 32px;
  line-height: 32px;
  margin: 0 4px 0 20px;
  overflow: hidden;
  padding-left: 32px;
  position: relative;
  text-decoration: none;
  background-color: hsla(0, 0%, 100%, 0.2);
}
.board-header-btn-name {
  cursor: default;
  font-size: 18px;
  font-weight: 700;
  line-height: 32px;
  padding-left: 4px;
  padding-right: 2px;
  white-space: nowrap;
}
.board-header-btn-text {
  padding-left: 8px;
  padding-right: 12px;
}
.board-header-btn-divider {
  float: left;
  border-left: 1px solid hsla(0, 0%, 100%, 0.2);
  height: 16px;
  margin: 8px 10px 0 20px;
}
</style>
