<template>
  <v-layout>
    <v-dialog v-model="boardDialog" persistent max-width="500px">
      <v-card>
        <v-form ref="form" v-model="valid">
          <v-card-title>
            <span class="headline">Create Board</span>
          </v-card-title>
          <v-card-text>
            <v-container grid-list-md>
              <v-layout row wrap>
                <v-flex xs12 sm12 md12>
                  <v-text-field label="Board Title" v-model="boardName" :rules="nameRules" outline></v-text-field>
                </v-flex>
                <v-flex xs12 sm12 md12>
                  <v-select :items="teamNames" v-model="team" label="Team" outline></v-select>
                </v-flex>
                <v-flex xs12 sm12 md12>
                  <v-select :items="items" v-model="boardScope" label="Scope" outline></v-select>
                </v-flex>
              </v-layout>
            </v-container>
          </v-card-text>
          <v-card-actions>
            <v-spacer></v-spacer>
            <v-btn color="blue" flat :disabled="!valid" @click="createBoard">Create</v-btn>
            <v-btn color="blue" flat @click="boardDialog = false">Close</v-btn>
          </v-card-actions>
        </v-form>
      </v-card>
    </v-dialog>
  </v-layout>
</template>

<script>
export default {
  props: ["dialog"],
  data() {
    return {
      valid: true,
      boardName: "",
      team: "No Team",
      boardScope: "Private",
      items: ["Private", "Public"],
      nameRules: [v => !!v || "Board name is required"]
    };
  },
  computed: {
    boardDialog: {
      get: function() {
        return this.dialog;
      },
      set: function(val) {
        this.$emit("updateBoardDialog", val);
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
      teams.unshift("No Team");
      return teams;
    }
  },
  methods: {
    createBoard() {
      if (this.$refs.form.validate()) {
        const userId = localStorage.getItem("userId");
        const teamId = this.team === "No Team" ? 0 : this.team;
        const scope = this.boardScope === "Private" ? 1 : 0;
        let board = {
          userId,
          teamId,
          boardName: this.boardName,
          scope
        };
        this.$store.dispatch("board/postBoard", board);
        this.$refs.form.reset();
        this.boardDialog = false;
      }
    }
  }
};
</script>

<style scoped>
.v-card__title {
  color: white;
  background-color: #026aa7;
}
</style>
