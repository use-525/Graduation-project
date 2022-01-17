import axios from "axios";

// state
export const state = {
  upgrades: [],
  upgrade: {},
  all: []
};

// getters
export const getters = {
  upgrade: state => state.upgrade,
  upgrades: state => state.upgrades,
  all: state => state.all
};

// mutations
export const mutations = {
  FETCH(state, upgrades) {
    state.upgrades = upgrades;
  },
  ALL(state, all) {
    state.all = all;
  },
  FETCH_ONE(state, upgrade) {
    state.upgrade = upgrade;
  }
};

// actions
export const actions = {
  fetch({ commit }) {
    return axios
      .get(route("upgrades"))
      .then(response => commit("FETCH", response.data.data))
      .catch();
  },
  all({ commit }) {
    return axios
      .get(route("all.upgrade"))
      .then(response => commit("ALL", response.data.data))
      .catch();
  },
  fetchOne({ commit }, id) {
    axios
      .get(route("show.upgrade", id))
      .then(response => commit("FETCH_ONE", response.data.data))
      .catch();
  },
  deleteUpgrade({}, id) {
    axios
      .delete(route("delete.upgrade", id))
      .then((response)=> {
        // this.dispatch("upgrade/fetch")
        if(response.data.status == 'success'){
        Swal.fire(
          'Deleted!',
          'upgrade deleted successfully',
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
  editUpgrade({}, data) {
    axios
      .post(route("update.upgrade", data.get('id')),data)
      .then()
  },
  addUpgrade({}, data) {
    axios
      .post(route("create.upgrade"), data)
      .then()
  }
};
