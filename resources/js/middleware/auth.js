import store from "../store";
import Cookies from "js-cookie";

export default async (to, from, next) => {
  if (store.getters['auth/token']) {
    await store.dispatch('auth/fetchUser')
    if (!store.getters["auth/check"]) {
      Cookies.set("intended_url", to.path);
      next({ name: "admin.login" });
    }
    if (Permissions.indexOf('login admin') == -1) {
      next({ name: 'home' })
    }
  }else{
    next({ name: "admin.login" });
  }
  
};