<template>
  <v-layout>
    <v-dialog v-model="teamDialog" persistent max-width="500px">
      <v-card>
        <v-form ref="form" v-model="valid">
          <v-card-title>
            <span class="headline">Create Team</span>
          </v-card-title>
          <v-card-text>
            <v-container grid-list-md>
              <v-layout row wrap>
                <v-flex xs12 sm12 md12>
                  <v-text-field label="Team Name" v-model="teamName" :rules="nameRules" outline></v-text-field>
                </v-flex>
                <v-flex xs12>
                  <v-textarea
                    outline
                    auto-grow
                    rows="1"
                    label="Team Description"
                    :rules="descriptionRules"
                    v-model="teamDescription"
                  ></v-textarea>
                </v-flex>
              </v-layout>
            </v-container>
          </v-card-text>
          <v-card-actions>
            <v-spacer></v-spacer>
            <v-btn color="blue" flat :disabled="!valid" @click="createTeam">Create</v-btn>
            <v-btn color="blue" flat @click="teamDialog = false">Close</v-btn>
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
      teamName: "",
      teamDescription: "",
      nameRules: [v => !!v || "Team name is required"],
      descriptionRules: [v => !!v || "Team Description is required"]
    };
  },
  computed: {
    teamDialog: {
      get: function() {
        return this.dialog;
      },
      set: function(val) {
        this.$emit("updateTeamDialog", val);
      }
    }
  },
  methods: {
    createTeam() {
      if (this.$refs.form.validate()) {
        const userId = localStorage.getItem("userId");
        let team = {
          userId,
          teamName: this.teamName,
          teamDescription: this.teamDescription
        };
        this.$store.dispatch("team/postTeam", team);
        this.$refs.form.reset();
        this.teamDialog = false;
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
