import axios from "axios"

// state

export const state = {
    messages: []
}

// getters
export const getters = {
        messages: state => state.messages
    }
    // mutation 
export const mutations = {
        FETCH(state, solutions) {
            state.solutions = solutions
        }
    }
    // action
export const actions = {
    fetch({ commit }) {
        return axios.get(route('fetchChat'))
            .then(res => commit("FETCH", res.data.data))
    },
    send({}, data) {
        return axios.post(route('sendChat'), data).then()
    }
}