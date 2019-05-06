<template>
  <div class="boardCanvas">
    <div id="board">
      <draggable v-model="boardLists" @start="isDragging=true" @end="isDragging=false">
        <div v-for="(list) in boardLists" :key="list.id" class="list-wrapper">
          <div class="list" @drop.stop @dragover.stop>
            <v-text-field
              style="padding-left:15px;padding-right:15px;"
              v-if="listNameChangeId === list.id"
              @keyup.enter="changeListName(list.id, list.listName)"
              v-model="list.listName"
            ></v-text-field>
            <v-btn
              v-else
              class="listButton"
              @drop.stop
              @dragover.stop
              @click="listNameChangeId = list.id"
            >{{ list.listName }}</v-btn>

            <div @drop.prevent="drop($event,list.id)" @dragover.prevent>
              <div v-if="list.Cards.length != 0">
                <draggable :v-model="list" @start="isDragging=true" @end="isDragging=false">
                  <v-layout v-for="card in list.Cards" :key="card.id" class="card">
                    <v-flex @drop.stop @dragover.stop>
                      <v-card
                        class="mx-auto"
                        style="border-radius:5px;"
                        tile
                        hover
                        draggable="true"
                        @dragstart="drag($event)"
                        @click="showCardModal(card.id)"
                        :id="card.id.toString()"
                      >
                        <v-card-text class="cardTitle">
                          <p style="margin-bottom:2px;">
                            {{ card.cardName }}
                            <v-icon
                              small
                              style="float:right; margin-right:20px;"
                              @click=";"
                            >mdi-pencil</v-icon>
                          </p>
                          <div v-if="card.Comments.length" style="display:inline;">
                            <v-icon small>mdi-comment-text-outline</v-icon>
                            <span style="font-size:13px;">{{ card.Comments.length }}</span>
                          </div>
                          <div v-if="card.Comments.length" style="display:inline;margin-left:5px;">
                            <v-icon small>mdi-checkbox-multiple-marked-outline</v-icon>
                            <span
                              style="font-size:13px;"
                            >{{ card.Comments.length +"/"+ card.Comments.length}}</span>
                          </div>
                        </v-card-text>
                      </v-card>
                    </v-flex>
                  </v-layout>
                </draggable>
              </div>
              <div
                style="height:10px;"
                v-else
                @drop.prevent="drop($event,list.id)"
                @dragover.prevent
              ></div>
            </div>

            <div class="text-xs-center">
              <v-menu
                :value="menuCard === list.id ? true : false"
                :close-on-content-click="false"
                :close-on-click="false"
                :nudge-width="40"
                origin="center center"
                transition="scale-transition"
              >
                <template v-slot:activator="{ on }">
                  <v-btn
                    class="listButton"
                    @drop.stop
                    @dragover.stop
                    @click="menuCard = list.id;"
                  >Add another card</v-btn>
                </template>
                <v-card>
                  <v-form ref="card">
                    <v-container grid-list-md>
                      <v-layout row wrap>
                        <v-flex>
                          <v-text-field label="Card Title" v-model="cardName" outline></v-text-field>
                        </v-flex>
                      </v-layout>
                    </v-container>
                    <v-card-actions>
                      <v-spacer></v-spacer>
                      <v-btn
                        color="primary"
                        flat
                        :disabled="!cardName"
                        @click.prevent="addCard(list.id)"
                      >Add Card</v-btn>
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
                <v-form ref="list">
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
                    <v-btn
                      color="primary"
                      flat
                      :disabled="!listName"
                      @click.prevent="addList"
                    >Add List</v-btn>
                    <v-btn color="primary" flat @click="resetListPopup">Cancel</v-btn>
                  </v-card-actions>
                </v-form>
              </v-card>
            </v-menu>
          </div>
        </div>
      </draggable>
    </div>
    <CardModal :dialog="cardDialog" v-on:updateCardDialog="updateCardDialog"/>
  </div>
</template>

<script>
import draggable from "vuedraggable";
import CardModal from "./CardModal.vue";

export default {
  data() {
    return {
      menuList: false,
      menuCard: false,
      listName: "",
      cardName: "",
      listNameChangeId: 0,
      cardDialog: false,
      nameRules: [v => !!v || "Title is required"],
      isDragging: false,
      delayedDragging: false
    };
  },
  components: {
    draggable,
    CardModal
  },
  computed: {
    selectedBoard() {
      return this.$store.state.board.selectedBoard;
    },
    boardLists: {
      get: function() {
        return this.$store.state.board.selectedBoard.Lists;
      },
      set: function(val) {
        this.$store.commit("board/setLists", val);
      }
    }
  },
  watch: {
    isDragging(newValue) {
      if (newValue) {
        this.delayedDragging = true;
        return;
      }
      this.$nextTick(() => {
        this.delayedDragging = false;
      });
    }
  },
  methods: {
    addList() {
      if (this.$refs.list.validate()) {
        let boardId = this.selectedBoard.id;
        this.$store.dispatch("list/postList", {
          boardId,
          listName: this.listName
        });
        this.resetListPopup();
      }
    },
    addCard(listId) {
      let boardId = this.selectedBoard.id;
      this.$store.dispatch("card/postCard", {
        listId,
        boardId,
        cardName: this.cardName
      });
      this.cardName = "";
      this.menuCard = false;
    },
    resetCardPopup() {
      this.cardName = "";
      this.menuCard = false;
    },
    resetListPopup() {
      this.$refs.list.reset();
      this.menuList = false;
    },
    drag(event) {
      event.dataTransfer.setData("cardId", event.target.id);
    },
    drop(event, listId) {
      var cardId = parseInt(event.dataTransfer.getData("cardId"));
      let boardId = this.selectedBoard.id;
      // event.target.appendChild(document.getElementById(data));
      let data = {
        cardId,
        change: { listId },
        boardId
      };
      this.$store.dispatch("card/patchCard", data);
    },
    changeListName(listId, listName) {
      let boardId = this.selectedBoard.id;
      let data = {
        listId,
        list: { listName },
        boardId
      };
      this.$store.dispatch("list/patchList", data);
      this.listNameChangeId = 0;
    },
    updateCardDialog(val) {
      this.cardDialog = val;
    },
    showCardModal(cardId) {
      this.$store.dispatch("card/getCardById", cardId);
      this.cardDialog = true;
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
  display: grid;
}
.listButton {
  margin-left: 11px;
  width: 92%;
}
.card {
  margin: 8px 10px;
}
.cardTitle {
  margin: 4px 10px;
}
</style>
