<template>
  <v-toolbar class="toolbar">
    <img src="../../public/trello-logo-white.svg" alt="Trello" width="130px" height="40px">
    <v-spacer></v-spacer>
    <v-btn flat to='/login' class="loginButton">Log In</v-btn>
    <v-btn flat to='/signup' class="signupButton">Sign Up</v-btn>
  </v-toolbar>
</template>

<script>
export default {};
</script>

<style> 
.v-toolbar__content{
  padding: 0px !important;
  height: 40px !important;
}
.toolbar {
  position: fixed;
  height: 72px;
  padding: 16px !important;
  background-color: #0079bf !important;
}
.loginButton {
  width: 67.25px;
  height: 36px !important;
  color: white !important;
  padding: 4px 8px;
  background-color: #0079bf !important;
  cursor: pointer;
}
.signupButton {
  width: 81.64px;
  height: 36px !important;
  color: #0079bf !important;
  padding: 4px 8px;
  border-radius: 5px;
  background-color: white !important;
  cursor: pointer;
}
</style>

