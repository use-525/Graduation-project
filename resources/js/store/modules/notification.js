import axios from "axios";

// state
export const state = {
  notifications: [],
  notification_by_user: [],
  notification: {},
};

// getters
export const getters = {
  notification: state => state.notification,
  notifications: state => state.notifications,
  notification_by_user: state => state.notification_by_user,
};

// mutations
export const mutations = {
  FETCH(state, notifications) {
    state.notifications = notifications;
  },
  BY_USER(state, notification_by_user) {
    state.notification_by_user = notification_by_user;
  },
  FETCH_ONE(state, notification) {
    state.notification = notification;
  }
};

// actions
export const actions = {
  fetch({ commit }) {
    return axios
      .get(route("notifications"))
      .then(response => commit("FETCH", response.data.data))
      .catch();
  },
  notificationByUser({ commit }) {
    return axios
      .get(route("byUser.notification"))
      .then(response => commit("BY_USER", response.data.data))
      .catch();
  },
  fetchOne({ commit }, id) {
    axios
      .get(route("show.notification", id))
      .then(response => commit("FETCH_ONE", response.data.data))
      .catch();
  },
  deleteNotification({}, id) {
    axios
      .delete(route("delete.notification", id))
      .then((response)=> {
        // this.dispatch("notification/fetch")
        if(response.data.status == 'success'){
        Swal.fire(
          'Đã xoá!',
          'Xoá thông báo thành công',
          'success'
        )
        }

    }).catch(() => {
        Swal.fire({
          icon: 'error',
          title: 'Oops...',
          text: 'Đã xảy ra lỗi!',
        })
    })
  },
  editNotification({}, data) {
    axios
      .post(route("update.notification", data.get('id')),data)
      .then()
  },
  addNotification({}, data) {
    axios
      .post(route("create.notification"), data)
      .then()
  }
};
