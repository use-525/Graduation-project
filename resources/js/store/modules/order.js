import axios from "axios";

// state
export const state = {
  orders: [],
  order: {},
};

// getters
export const getters = {
  order: state => state.order,
  orders: state => state.orders,
};

// mutations
export const mutations = {
  FETCH(state, orders) {
    state.orders = orders;
  },
  FETCH_ONE(state, order) {
    state.order = order;
  }
};

// actions
export const actions = {
  fetch({ commit }) {
    return axios
      .get(route("orders"))
      .then(response => commit("FETCH", response.data.data))
      .catch();
  },
  fetchOne({ commit }, id) {
    axios
      .get(route("show.order", id))
      .then(response => commit("FETCH_ONE", response.data.data))
      .catch();
  },
  deleteOrder({}, id) {
    axios
      .delete(route("delete.order", id))
      .then((response)=> {
        // this.dispatch("order/fetch")
        if(response.data.status == 'success'){
        Swal.fire(
          'Deleted!',
          'order deleted successfully',
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
  editOrder({}, data) {
    axios
      .post(route("update.order", data.get('id')),data)
      .then()
  },
  addOrder({}, data) {
    axios
      .post(route("create.order"), data)
      .then()
  }
};
