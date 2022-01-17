import axios from "axios";

// state
export const state = {
    challenges: [],
    challenge: {},
    all: []
};

// getters
export const getters = {
    challenge: state => state.challenge,
    challenges: state => state.challenges,
    all: state => state.all
};

// mutations
export const mutations = {
    FETCH(state, challenges) {
        state.challenges = challenges;
    },
    FETCH_ONE(state, challenge) {
        state.challenge = challenge;
    },
    ALL(state, all) {
        state.all = all;
    }
};

// actions
export const actions = {
    fetch({ commit }) {
        return axios
            .get(route("challenges"))
            .then(response => commit("FETCH", response.data.data))
    },
    fetchOne({ commit }, id) {
        axios
            .get(route("show.challenge", id))
            .then(response => commit("FETCH_ONE", response.data.data))
    },
    fet_One_Data({ commit }, slug) {
        axios
            .get(route("get_One.challenge", slug))
            .then(response => commit("FETCH_ONE", response.data.data))
    },
    fetchByCate({ commit }, slug) {
        axios
            .get(route("get_One.challengecategory", slug))
            .then(response => commit("FETCH_ONE", response.data.data))
    },
    all({ commit }) {
        return axios
            .get(route("all.challenge"))
            .then(response => commit("ALL", response.data.data))
    },
    deletechallenge({}, id) {
        axios
            .delete(route("delete.challenge", id))
            .then((response) => {
                // this.dispatch("challenge/fetch")
                if (response.data.status == 'success') {
                    Swal.fire(
                        'Deleted!',
                        'challenge deleted successfully',
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
    editchallenge({}, data) {
        axios
            .post(route("update.challenge", data.get('id')), data)
            .then()
    },
    addchallenge({}, data) {
        axios
            .post(route("create.challenge"), data)
            .then()
    }
};
