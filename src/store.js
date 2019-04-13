import Vue from 'vue'
import Vuex from 'vuex'

// Store functionality
import actions from './store/actions'
import getters from './store/getters'
import mutations from './store/mutations'
import state from './store/state'
import team from './store/teamModule'
import board from './store/boardModule'
import user from './store/userModule'

Vue.use(Vuex)

// Create a new store
export default new Vuex.Store({
  actions,
  getters,
  modules: {
    team,
    board,
    user
  },
  mutations,
  state
})

