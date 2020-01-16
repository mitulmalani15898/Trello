import Vue from "vue";
import Vuetify from "vuetify";
import "vuetify/dist/vuetify.min.css";
import "@mdi/font/css/materialdesignicons.css";
import axios from "axios";

import App from "./App.vue";
import router from "./router";
import store from "./store";

Vue.config.productionTip = false;
Vue.use(Vuetify, {
  iconfont: "mdi"
});

axios.defaults.baseURL = "http://192.168.2.10:8087/";

new Vue({
  router,
  store,
  render: h => h(App)
}).$mount("#app");
