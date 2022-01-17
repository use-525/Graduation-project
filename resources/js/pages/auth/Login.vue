<template>
  <div class="login-wrapper">
    <!-- login form -->
    <div class="auth-form">
      <div class="auth-form__container">
        <div class="auth-form__header py-2">
          <h2 class="login-title">Đăng nhập</h2>
        </div>

        <form
          id="login-form"
          @submit.prevent="login"
          @keydown="form.onKeydown($event)"
        >
          <div class="auth-form__form">
            <div class="auth-form__group">
              <input
                v-model="form.email"
                :class="{
                  'is-invalid': form.errors.has('email'),
                }"
                type="email"
                name="email"
                placeholder="Email"
                class="auth-form__input"
              />
              <div
                class="text-danger"
                v-if="form.errors.has('email')"
                v-html="form.errors.get('email')"
              />
            </div>
            <div class="auth-form__group">
              <input
                v-model="form.password"
                :class="{
                  'is-invalid': form.errors.has('password'),
                }"
                type="password"
                name="password"
                placeholder="Mật khẩu"
                class="auth-form__input"
              />
              <div
                class="text-danger"
                v-if="form.errors.has('password')"
                v-html="form.errors.get('password')"
              />
            </div>
          </div>
          <div class="auth-form__group mt-3">
            <label class="ui-checkbox ui-checkbox-info">
              <input type="checkbox" v-model="form.remember" name="remember" />
              <span class="input-span"></span>Nhớ tài khoản</label
            >
          </div>
          <div class="auth-form__aside">
            <div class="auth-form-help">
              <router-link
                :to="{ name: 'forgot.pass' }"
                class="auth-form__help-link auth-form-help-fogot"
                >Quên mật khẩu</router-link
              >
              <span class="auth-form-help-separate"> </span>
              <!-- <a href="#" class="auth-form__help-link">Cần trợ giúp?</a> -->
              <router-link
                :to="{ name: 'register' }"
                class="auth-form__help-link auth-form-help-fogot"
                >Đăng ký</router-link
              >
            </div>
          </div>

          <div class="auth-form__controls">
            <span class="btn auth-form__controls-back">
              <router-link :to="{ name: 'home' }">Trở lại</router-link>
            </span>
            <button
              class="btn btn-dark m-auto"
              type="button"
              @click="loginGithub"
            >
              Đăng nhập bằng Github
              <i class="fa fa-github"></i>
            </button>
            <button
              type="submit"
              class="btn btn-primary"
              style="cursor: pointer"
            >
              Đăng nhập
            </button>
          </div>
        </form>
      </div>
    </div>
    <!-- end login -->
  </div>
</template>
<script>
import Cookies from "js-cookie";
export default {
  data: () => ({
    form: new Form({
      email: "",
      password: "",
      remember: false,
    }),
  }),
  methods: {
    async login() {
      // Submit the form.
      const { data } = await this.form.post(route("login"));
      // Save the token.
      this.$store.dispatch("auth/saveToken", {
        token: data.access_token,
        remember: this.form.remember,
      });
      // Fetch the user.
      await this.$store.dispatch("auth/fetchUser");
      // Redirect home.
      this.redirect();
    },
    async loginGithub() {
      window.location.href = route("redirect.github");
    },
    redirect() {
      const intendedUrl = Cookies.get("intended_url");
      if (intendedUrl) {
        Cookies.remove("intended_url");
        this.$router.push({ path: intendedUrl });
      } else {
        this.$router.push({ name: "home" });
      }
    },
  },
};
</script>
<style scoped>
@import "../../../sass/auth.css";
</style>
