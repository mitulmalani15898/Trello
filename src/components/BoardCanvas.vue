<template>
  <div class="boardCanvas">
    <div id="board">
      <div class="list-wrapper">
        <div class="list">
          <v-btn class="listButton">List Title</v-btn>
          <v-layout class="card">
            <v-flex>
              <v-card class="mx-auto" style="border-radius:5px;" tile hover>
                <v-card-title>
                  <span>Card Name</span>
                </v-card-title>
                <v-card-text>"Turns out semicolon-less"</v-card-text>
              </v-card>
            </v-flex>
          </v-layout>
          <div class="text-xs-center">
            <v-menu
              v-model="menuCard"
              :close-on-content-click="false"
              :nudge-width="40"
              origin="center center"
              transition="scale-transition"
            >
              <template v-slot:activator="{ on }">
                <v-btn class="listButton" v-on="on">Add another card</v-btn>
              </template>
              <v-card>
                <v-form ref="card" v-model="valid">
                  <v-container grid-list-md>
                    <v-layout row wrap>
                      <v-flex>
                        <v-text-field
                          label="Card Title"
                          v-model="cardName"
                          :rules="nameRules"
                          outline
                        ></v-text-field>
                      </v-flex>
                    </v-layout>
                  </v-container>
                  <v-card-actions>
                    <v-spacer></v-spacer>
                    <v-btn color="primary" flat :disabled="!valid" @click="addCard">Add Card</v-btn>
                    <v-btn color="primary" flat @click="resetCardPopup">Cancel</v-btn>
                  </v-card-actions>
                </v-form>
              </v-card>
            </v-menu>
          </div>
        </div>
      </div>
      <div class="list-wrapper">
        <div class="text-xs-center">
          <v-menu
            v-model="menuList"
            :close-on-content-click="false"
            :nudge-width="40"
            origin="center center"
            transition="scale-transition"
          >
            <template v-slot:activator="{ on }">
              <v-btn class="addListButton" color="#6a8bcc" dark v-on="on">Add another list</v-btn>
            </template>
            <v-card>
              <v-form ref="list" v-model="valid">
                <v-container grid-list-md>
                  <v-layout row wrap>
                    <v-flex>
                      <v-text-field
                        label="List Title"
                        v-model="listName"
                        :rules="nameRules"
                        outline
                      ></v-text-field>
                    </v-flex>
                  </v-layout>
                </v-container>
                <v-card-actions>
                  <v-spacer></v-spacer>
                  <v-btn color="primary" flat :disabled="!valid" @click="addList">Add List</v-btn>
                  <v-btn color="primary" flat @click="resetListPopup">Cancel</v-btn>
                </v-card-actions>
              </v-form>
            </v-card>
          </v-menu>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  data() {
    return {
      valid: true,
      menuList: false,
      menuCard: false,
      listName: "",
      cardName: "",
      nameRules: [v => !!v || "Title is required"]
    };
  },
  methods: {
    addList() {
      if (this.$refs.list.validate()) {
        //
      }
    },
    addCard() {
      if (this.$refs.card.validate()) {
        //
      }
    },
    resetCardPopup() {
      this.$refs.card.reset();
      this.menuCard = false;
    },
    resetListPopup() {
      this.$refs.list.reset();
      this.menuList = false;
    }
  }
};
</script>

<style>
.boardCanvas {
  background-color: rgb(192, 215, 247);
  top: 100px;
  height: 100vh;
  position: relative;
  flex-grow: 1;
}
#board {
  margin: 10px;
  overflow-x: scroll;
  overflow-y: hidden;
  padding-bottom: 8px;
  position: absolute;
  top: 0;
  right: 0;
  bottom: 0;
  left: 0;
}
.list-wrapper {
  width: 272px;
  margin: 5px;
  height: 100%;
  box-sizing: border-box;
  display: inline-block;
  vertical-align: top;
  white-space: nowrap;
}
.addListButton {
  width: 90%;
}
.list {
  background-color: rgb(150, 175, 223);
  border-radius: 5px;
}
.listButton {
  margin-left: 11px;
  width: 92%;
}
.card {
  margin: 5px 10px;
}
</style>
