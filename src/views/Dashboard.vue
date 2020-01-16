<template>
  <div>
    <UserHeader />
    <UserVerticalNavbar />
    <DisplayBoards />
  </div>
</template>

<script>
// @ is an alias to /src
import UserHeader from "@/components/UserHeader.vue";
import UserVerticalNavbar from "@/components/UserVerticalNavbar.vue";
import DisplayBoards from "@/components/DisplayBoards.vue";

export default {
  components: {
    UserHeader,
    UserVerticalNavbar,
    DisplayBoards
  }
};
</script>
