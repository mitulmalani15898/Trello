<template>
  <v-layout row justify-center>
    <v-dialog v-model="cardDialog" persistent max-width="700px">
      <v-card>
        <v-card-title v-if="selectedCard">
          <span class="headline">{{ selectedCard.cardName }}</span>
          <v-spacer></v-spacer>
          <v-icon @click="cardDialog=false" color="black">mdi-close-circle</v-icon>
        </v-card-title>
        <v-card-text>
          <v-container grid-list-md>
            <v-layout wrap>
              <span class="headline">Description</span>
              <br>
              <button>Edit</button>
              <v-flex xs12 sm12 md12>
                <v-textarea outline rows="2" auto-grow></v-textarea>
                <v-btn class="vbutton" color="blue" flat @click="cardDialog = false">Save</v-btn>
              </v-flex>
              <span class="headline">Add Comment</span>
              <v-flex xs12 sm12 md12>
                <v-textarea outline rows="2" auto-grow></v-textarea>
                <v-btn class="vbutton" color="blue" flat @click="cardDialog = false">Save</v-btn>
              </v-flex>
            </v-layout>
          </v-container>
        </v-card-text>
      </v-card>
    </v-dialog>
  </v-layout>
</template>

<script>
export default {
  props: ["dialog"],
  data() {
    return {
      //
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
    lists() {
      if (this.selectedCard) {
        return this.$store.state.board.selectedBoard.Lists;
      }
    },
    selectedCardList() {
      if (this.lists) {
        let list = this.lists.filter(
          list => list.id === this.selectedCard.listId
        );
        return list[0];
      }
    }
  }
};
</script>

<style>
.v-card__text {
  padding: 3px;
}
.v-textarea {
  margin: 10px;
  padding: 5px;
}
.vbutton {
  margin-top: -20px;
}
</style>

