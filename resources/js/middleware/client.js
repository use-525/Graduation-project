import store from '../store'

export default async (to, from, next) => {
  if (store.getters['auth/token']) {
    await store.dispatch('auth/fetchUser')
    if (store.getters['auth/check']) {
      next({ name: 'homeDashboard' })
    }
  }else{
    next()
  }
    
}