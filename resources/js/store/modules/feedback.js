import axios from "axios";

// state
export const state = {
  feedbacks: [],
  feedback: {},
  all: [],
  feedbackByCate: [],
};

// getters
export const getters = {
  feedback: state => state.feedback,
  feedbacks: state => state.feedbacks,
  all: state => state.all,
  feedbackByCate: state => state.feedbackByCate,
};

// mutations
export const mutations = {
  FETCH(state, feedbacks) {
    state.feedbacks = feedbacks;
  },
  ALL(state, all) {
    state.all = all;
  },
  BY_CATE(state, feedbackByCate) {
    state.feedbackByCate = feedbackByCate;
  },
  FETCH_ONE(state, feedback) {
    state.feedback = feedback;
  }
};

// actions
export const actions = {
  fetch({ commit }) {
    return axios
      .get(route("feedbacks"))
      .then(response => commit("FETCH", response.data.data))
  },
  all({ commit }) {
    return axios
      .get(route("all.feedback"))
      .then(response => commit("ALL", response.data.data))
  },
  fetchOne({ commit }, id) {
    axios
      .get(route("show.feedback", id))
      .then(response => commit("FETCH_ONE", response.data.data))
  },
  byCate({ commit }, slug) {
    axios
      .get(route("feedback.byCate", slug))
      .then(response => commit("BY_CATE", response.data.data))
  },
  deleteFeedback({}, id) {
    axios
      .delete(route("delete.feedback", id))
      .then((response)=> {
        // this.dispatch("feedback/fetch")
        if(response.data.status == 'success'){
        Swal.fire(
          'Deleted!',
          'feedback deleted successfully',
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
  editFeedback({}, data) {
    axios
      .post(route("update.feedback", data.get('id')),data)
      .then()
  },
  updateApproved({}, id) {
    axios
      .post(route("approved.feedback",id))
      .then((response)=> {
        // this.dispatch("feedback/fetch")
        if(response.data.status == 'success'){
        Swal.fire(
          'Đã duyệt!',
          'Bình luận đã được duyệt',
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
  addFeedback({}, data) {
    axios
      .post(route("create.feedback"), data)
      .then()
  }
  
};
