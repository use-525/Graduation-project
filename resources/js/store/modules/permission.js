import axios from "axios";

// state
export const state = {
  permissions: [],
  permission: {},
  all: []
};

// getters
export const getters = {
  permission: state => state.permission,
  permissions: state => state.permissions,
  all: state => state.all
};

// mutations
export const mutations = {
  FETCH(state, permissions) {
    state.permissions = permissions;
  },
  ALL(state, all) {
    state.all = all;
  },
  FETCH_ONE(state, permission) {
    state.permission = permission;
  }
};

// actions
export const actions = {
  fetch({ commit }) {
    return axios
      .get(route("permissions"))
      .then(response => commit("FETCH", response.data.data))
      .catch();
  },
  all({ commit }) {
    return axios
      .get(route("all.permission"))
      .then(response => commit("ALL", response.data.data))
      .catch();
  },
  fetchOne({ commit }, id) {
    axios
      .get(route("show.permission", id))
      .then(response => commit("FETCH_ONE", response.data.data))
      .catch();
  },
  deletePermission({}, id) {
    axios
      .delete(route("delete.permission", id))
      .then((response)=> {
        // this.dispatch("permission/fetch")
        if(response.data.status == 'success'){
        Swal.fire(
          'Deleted!',
          'Permission deleted successfully',
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
  editPermission({}, data) {
    axios
      .post(route("update.permission", data.get('id')),data)
      .then()
  },
  addPermission({}, data) {
    axios
      .post(route("create.permission"), data)
      .then()
  }
};
