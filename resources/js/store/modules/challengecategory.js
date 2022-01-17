import axios from "axios";

// state
export const state = {
    challengecategories: [],
    challengecategory: {},
    all: []
};

// getters
export const getters = {
    challengecategory: state => state.challengecategory,
    challengecategories: state => state.challengecategories,
    all: state => state.all
};

// mutations
export const mutations = {
    FETCH(state, challengecategories) {
        state.challengecategories = challengecategories;
    },
    FETCH_ONE(state, challengecategory) {
        state.challengecategory = challengecategory;
    },
    ALL(state, all) {
        state.all = all;
    }
};

// actions
export const actions = {
    fetch({ commit }) {
        return axios
            .get(route("challengecategories"))
            .then(response => commit("FETCH", response.data.data))
    },
    all({ commit }) {
        return axios
            .get(route("all.challengecategory"))
            .then(response => commit("ALL", response.data.data))
    },
    get_All_Data({ commit }) {
        return axios
            .get(route("get_All.challengecategory"))
            .then(response => commit("FETCH", response.data.data))
    },
    fetchOne({ commit }, id) {
        axios
            .get(route("show.challengecategory", id))
            .then(response => commit("FETCH_ONE", response.data.data))
    },
    get_One_Data({ commit }, slug) {
        axios
            .get(route("bySlug.challengecategory", slug))
            .then(response => commit("FETCH_ONE", response.data.data))
    },
    getOneByChall({ commit }, slug) {
        axios
            .get(route("bySlugChall.challengecategory", slug))
            .then(response => commit("FETCH_ONE", response.data.data))
    },
    deletechallengecategory({}, id) {
        axios
            .delete(route("delete.challengecategory", id))
            .then((response) => {
                // this.dispatch("challengecategory/fetch")
                if (response.data.status == 'success') {
                    Swal.fire(
                        'Deleted!',
                        'challengecategory deleted successfully',
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
    editchallengecategory({}, data) {
        axios
            .post(route("update.challengecategory", data.get('id')), data)
            .then()
    },
    addChallengeCategory({}, data) {
        axios
            .post(route("create.challengecategory"), data)
            .then()
    }
};
