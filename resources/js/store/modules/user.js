import axios from "axios";

// state
export const state = {
  users: [],
  user: {},
  all: []
};

// getters
export const getters = {
  user: state => state.user,
  users: state => state.users,
  all: state => state.all
};

// mutations
export const mutations = {
  FETCH(state, users) {
    state.users = users;
  },
  ALL(state, all) {
    state.all = all;
  },
  FETCH_ONE(state, user) {
    state.user = user;
  }
};

// actions
export const actions = {
  fetch({ commit }) {
    return axios
      .get(route("users"))
      .then(response => commit("FETCH", response.data.data))
  },
  all({ commit }) {
    return axios
      .get(route("all.user"))
      .then(response => commit("ALL", response.data.data))
  },
  fetchOne({ commit }, id) {
    axios
      .get(route("show.user", id))
      .then(response => commit("FETCH_ONE", response.data.data))
  },
  deleteUser({}, id) {
    axios
      .delete(route("delete.user", id))
      .then((response)=> {
        // this.dispatch("user/fetch")
        if(response.data.status == 'success'){
        Swal.fire(
          'Deleted!',
          'User deleted successfully',
          'success'
        )
        }

    }).catch(() => {
        Swal.fire({
          icon: 'error',
          title: 'Oops...',
          text: 'Something went wrong!',
        })
    })
  },
  editUser({}, data) {
    axios
      .post(route("update.user", data.get('id')),data)
      .then()
  },
  addUser({}, data) {
    axios
      .post(route("create.user"), data)
      .then()
  }
  
};
