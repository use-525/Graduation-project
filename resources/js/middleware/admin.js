import store from '../store'

export default (to, from, next) => {
  if (store.getters['auth/user'].roles[0].id != 2) {
    next({ name: 'home' })
  } else {
    next()
  }
}