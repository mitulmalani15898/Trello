<template>
  <div class="board">
    <UserHeader/>
    <BoardHeader/>
    <BoardCanvas/>
  </div>
</template>

<script>
import UserHeader from "../components/UserHeader.vue";
import BoardHeader from "../components/BoardHeader.vue";
import BoardCanvas from "../components/BoardCanvas.vue";

export default {
  components: {
    UserHeader,
    BoardHeader,
    BoardCanvas
  },
  beforeCreate() {
    this.$store.dispatch("board/getBoardById", this.$route.params.boardId);
    history.pushState(null, null, location.href);
    window.onpopstate = function() {
      history.go(1);
    };
  }
};
</script>

<style>
.board {
  overflow-y: hidden;
  background-color: rgb(192, 215, 247);
}
</style>

