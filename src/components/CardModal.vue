<template>
  <v-layout row justify-center>
    <v-dialog v-model="cardDialog" persistent max-width="600px">
      <v-card>
        <v-card-title v-if="selectedCard" class="modalTitle">
          <span class="headline">
            {{ selectedCard.cardName }}
            <small style="color:black;">in</small>
            <!-- {{ selectedCardList.listName }} -->
          </span>
          <v-spacer></v-spacer>
          <v-icon @click="cardDialog = false" color="white">
            mdi-close-circle
          </v-icon>
        </v-card-title>
        <v-card-text>
          <v-container grid-list-md>
            <v-layout wrap>
              <div class="text-xs-center">
                <v-menu
                  v-model="dueDateDialog"
                  :close-on-content-click="false"
                  :nudge-width="200"
                  offset-y
                >
                  <template v-slot:activator="{ on }">
                    <div class="board-header-btn1 board-header-btn-name">
                      <button class="board-header-btn-text" v-on="on">
                        Due Date
                      </button>
                    </div>
                  </template>
                  <div>
                    <div style="margin:10px;">
                      <center>
                        <span class="headline">Change Due Date</span>
                      </center>
                      <v-flex xs12 sm12>
                        <v-date-picker v-model="date"></v-date-picker>
                      </v-flex>
                      <v-flex>
                        <v-text-field
                          label="Date"
                          v-model="date"
                          outline
                        ></v-text-field>
                      </v-flex>
                      <v-flex>
                        <v-select
                          :items="['0-17', '18-29']"
                          label="Set Reminder"
                          outline
                        ></v-select>
                      </v-flex>
                      <v-btn color="blue" flat @click="dueDateDialog = false">
                        Save
                      </v-btn>
                      <v-btn color="red" flat @click="dueDateDialog = false">
                        Remove
                      </v-btn>
                    </div>
                  </div>
                </v-menu>
              </div>

              <div class="text-xs-center">
                <v-menu
                  v-model="membersDialog"
                  :close-on-content-click="false"
                  :nudge-width="200"
                  offset-y
                >
                  <template v-slot:activator="{ on }">
                    <div class="board-header-btn1 board-header-btn-name">
                      <button class="board-header-btn-text" v-on="on">
                        Members
                      </button>
                    </div>
                  </template>
                  <div>
                    <div style="margin:10px;">
                      <v-flex>
                        <v-text-field
                          label="Search Members"
                          outline
                        ></v-text-field>
                      </v-flex>
                    </div>
                  </div>
                </v-menu>
              </div>

              <div class="text-xs-center">
                <v-menu
                  v-model="checkListDialog"
                  :close-on-content-click="false"
                  :nudge-width="200"
                  offset-y
                >
                  <template v-slot:activator="{ on }">
                    <div class="board-header-btn1 board-header-btn-name">
                      <button class="board-header-btn-text" v-on="on">
                        CheckList
                      </button>
                    </div>
                  </template>
                  <div>
                    <div style="margin:10px;">
                      <v-flex>
                        <v-text-field label="Title" outline></v-text-field>
                      </v-flex>
                      <v-btn color="blue" flat @click="checkListDialog = false">
                        Add
                      </v-btn>
                    </div>
                  </div>
                </v-menu>
              </div>

              <v-flex xs12 sm12 md12>
                <br />
                <hr />
                <br />
              </v-flex>

              <v-flex xs12 sm12 md12>
                <span class="headline">Description</span>&nbsp;&nbsp;
                <button
                  v-if="!showDescription"
                  style="color:#026aa7;"
                  @click="showDescription = true"
                >
                  Edit
                </button>
                <v-textarea
                  v-if="showDescription"
                  outline
                  rows="1"
                  auto-grow
                  v-model="description"
                  :value="selectedCard.description"
                ></v-textarea>
                <p v-if="!showDescription">
                  {{
                    selectedCard.description || "Add more detailed description"
                  }}
                </p>
                <v-btn
                  v-if="showDescription"
                  class="vbutton"
                  color="blue"
                  flat
                  @click="addDescription"
                >
                  Save
                </v-btn>
                <v-btn
                  v-if="showDescription"
                  class="vbutton"
                  color="red"
                  flat
                  @click="showDescription = false"
                >
                  Cancel
                </v-btn>
                <hr />
                <br />
              </v-flex>

              <v-flex xs12 sm12 md12>
                <div v-for="cmnt in selectedCardsComments" :key="cmnt.id">
                  <p
                    style="font-weight:bold; margin-left:10px;margin-bottom:8px;"
                  >
                    Mitul Malani
                  </p>
                  <span
                    v-if="showComment !== cmnt.id"
                    style="background-color:black; color:white; margin-left:12px; padding:4px 10px;"
                  >
                    {{ cmnt.comment }}
                  </span>

                  <div v-if="showComment !== cmnt.id" style="margin-top:10px;">
                    <button
                      style="color:#026aa7; margin-left:10px;"
                      @click="showComment = cmnt.id"
                    >
                      Edit
                    </button>
                    &nbsp;&nbsp;
                    <button
                      style="color:#026aa7;"
                      @click="deleteCommentDialogOpen(cmnt.id)"
                    >
                      Delete
                    </button>
                  </div>

                  <div v-if="showComment == cmnt.id">
                    <v-textarea
                      outline
                      rows="1"
                      auto-grow
                      v-model="cmnt.comment"
                    ></v-textarea>
                    <v-btn
                      class="vbutton"
                      color="blue"
                      flat
                      @click="updateComment(cmnt.id, cmnt.comment)"
                    >
                      Save
                    </v-btn>
                    <v-btn
                      class="vbutton"
                      color="red"
                      flat
                      @click="showComment = false"
                    >
                      Cancel
                    </v-btn>
                  </div>

                  <br />
                  <hr />
                  <br />
                </div>
              </v-flex>

              <v-flex xs12 sm12 md12>
                <span class="headline">Add Comment</span>
                <v-textarea
                  outline
                  rows="1"
                  auto-grow
                  v-model="comment"
                ></v-textarea>
                <v-btn
                  class="vbutton"
                  color="blue"
                  flat
                  :disabled="!comment"
                  @click="addComment"
                >
                  Save
                </v-btn>
                <hr />
                <br />
              </v-flex>

              <v-flex xs12 sm12 md12>
                <span class="headline">CheckList</span>&nbsp;&nbsp;&nbsp;&nbsp;
                <span>{{ Math.round(this.checkListCompleted) }}%</span>
                <v-progress-linear
                  v-model="checkListCompleted"
                ></v-progress-linear>
                <template v-for="i in 3">
                  <v-checkbox
                    class="checkbox"
                    color="blue"
                    v-model="selected"
                    :key="i"
                    label="John"
                    :value="i"
                  ></v-checkbox>
                </template>
                <v-text-field
                  v-if="showAddItem"
                  label="Title"
                  v-model="addItem"
                  outline
                ></v-text-field>
                <v-btn
                  v-if="showAddItem"
                  class="vbutton"
                  color="blue"
                  flat
                  :disabled="!addItem"
                  @click="showAddItem = false"
                >
                  Save
                </v-btn>
                <v-btn
                  v-if="showAddItem"
                  class="vbutton"
                  color="red"
                  flat
                  @click="showAddItem = false"
                >
                  Cancel
                </v-btn>
                <v-btn
                  v-if="!showAddItem"
                  color="blue"
                  flat
                  @click="showAddItem = true"
                >
                  Add an item
                </v-btn>
              </v-flex>
            </v-layout>
          </v-container>
        </v-card-text>
      </v-card>
    </v-dialog>
    <div class="text-xs-center">
      <v-dialog v-model="deleteCommentDialog" width="300">
        <v-card>
          <v-card-title style="font-size:15px;">
            Are you sure to delete Comment?
          </v-card-title>
          <v-divider></v-divider>
          <v-card-actions>
            <v-spacer></v-spacer>
            <v-btn color="red" flat @click="deleteComment">Delete</v-btn>
            <v-btn color="primary" flat @click="deleteCommentDialog = false">
              Cancel
            </v-btn>
          </v-card-actions>
        </v-card>
      </v-dialog>
    </div>
  </v-layout>
</template>

<script>
export default {
  props: ["dialog"],
  data() {
    return {
      date: new Date().toISOString().substr(0, 10),
      dueDateDialog: false,
      membersDialog: false,
      deleteCommentDialog: false,
      checkListDialog: false,
      showDescription: false,
      showComment: false,
      showAddItem: false,
      deleteCommentId: 0,
      newDescription: "",
      comment: "",
      newComment: "",
      checkListCompleted: 0,
      selected: [],
      addItem: ""
    };
  },
  computed: {
    cardDialog: {
      get: function() {
        return this.dialog;
      },
      set: function(val) {
        this.$emit("updateCardDialog", val);
      }
    },
    selectedCard() {
      return this.$store.state.card.card;
    },
    selectedBoard() {
      return this.$store.state.board.selectedBoard;
    },
    selectedCardsComments() {
      return this.$store.state.card.card.Comments;
    },
    lists() {
      if (this.selectedCard) {
        return this.$store.state.board.selectedBoard.Lists;
      } else {
        return [];
      }
    },
    selectedCardList() {
      if (this.lists) {
        let list = this.lists.filter(
          list => list.id === this.selectedCard.listId
        );
        return list[0];
      } else {
        return [];
      }
    },
    description: {
      get: function() {
        return this.$store.state.card.card.description
          ? this.$store.state.card.card.description
          : "";
      },
      set: function(val) {
        this.newDescription = val;
      }
    }
  },
  watch: {
    selected() {
      this.checkListCompleted = (this.selected.length * 100) / 3;
    }
  },
  methods: {
    addDescription() {
      let data = {
        cardId: this.selectedCard.id,
        boardId: this.selectedBoard.id,
        change: { description: this.newDescription }
      };
      this.$store.dispatch("card/patchCard", data);
      this.showDescription = false;
    },
    addComment() {
      let data = {
        cardId: this.selectedCard.id,
        userId: parseInt(localStorage.getItem("userId")),
        boardId: this.selectedBoard.id,
        comment: this.comment
      };
      this.$store.dispatch("comment/postComment", data);
      this.comment = "";
    },
    updateComment(commentId, value) {
      let data = {
        commentId,
        cardId: this.selectedCard.id,
        boardId: this.selectedBoard.id,
        change: { comment: value }
      };
      this.$store.dispatch("comment/patchComment", data);
      this.showComment = false;
      this.comment = "";
    },
    deleteCommentDialogOpen(id) {
      this.deleteCommentDialog = true;
      this.deleteCommentId = id;
    },
    deleteComment() {
      this.$store.dispatch("comment/deleteComment", {
        commentId: this.deleteCommentId,
        cardId: this.selectedCard.id,
        boardId: this.selectedBoard.id
      });
      this.deleteCommentDialog = false;
    }
  }
};
</script>

<style>
.v-card__text {
  padding: 3px;
}
.modalTitle {
  color: white;
  background-color: #026aa7;
}
.v-textarea {
  margin: 10px;
  padding: 5px;
}
.vbutton {
  margin-top: -20px;
}
.v-picker__title {
  background-color: #026aa7 !important;
}
.board-header-btn1 {
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
  background-color: #026aa7;
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
.v-menu__content {
  background-color: white;
}
.checkbox {
  margin: 0px;
  padding: 0px;
  height: 25px;
}
</style>
