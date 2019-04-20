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
          <v-icon @click="cardDialog=false" color="white">mdi-close-circle</v-icon>
        </v-card-title>
        <v-card-text>
          <v-container grid-list-md>
            <v-layout wrap>
              <v-flex xs12 sm12 md12>
                <span class="headline">Description</span>&nbsp;&nbsp;
                <button
                  v-if="!showDescription"
                  style="color:#026aa7;"
                  @click="showDescription=true"
                >Edit</button>
                <v-textarea
                  v-if="showDescription"
                  outline
                  rows="1"
                  auto-grow
                  :value="selectedCard.description"
                ></v-textarea>  
                <p v-if="!showDescription">{{ selectedCard.description }}</p>
                <v-btn
                  v-if="showDescription"
                  class="vbutton"
                  color="blue"
                  flat
                  @click="showDescription = false"
                >Save</v-btn>
                <v-btn
                  v-if="showDescription"
                  class="vbutton"
                  color="blue"
                  flat
                  @click="showDescription = false"
                >Cancel</v-btn>
              </v-flex>
              <v-flex xs12 sm12 md12>
                <span class="headline">Add Comment</span>
                <v-textarea outline rows="1" auto-grow></v-textarea>
                <v-btn class="vbutton" color="blue" flat @click=";">Save</v-btn>
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
      showDescription: false
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
</style>

