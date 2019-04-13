<template>
  <div>
    <div class="boardHeader">
      <div class="board-header-btn board-header-btn-name">
        <button class="board-header-btn-text">{{ selectedBoard.boardName }}</button>
      </div>
      <span class="board-header-btn-divider"></span>
      <a class="board-header-btn board-header-btn-text" href="#">Personal</a>
      <span class="board-header-btn-divider"></span>
      <a class="board-header-btn board-header-btn-text" href="#">Private</a>
    </div>
  </div>
</template>

<script>
export default {
  data() {
    return {
      //
    };
  },
  computed: {
    selectedBoard() {
      return this.$store.state.board.selectedBoard;
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
