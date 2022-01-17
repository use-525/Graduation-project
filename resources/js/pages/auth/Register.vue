<template>
  <div class="login-wrapper">
    <div class="auth-form">
      <div class="auth-form__container">
        <div class="auth-form__header">
          <h2 class="">Đăng ký tài khoản</h2>
        </div>

        <form @submit.prevent="register" @keydown="form.onKeydown($event)">
          <div class="auth-form__form">
            <div class="auth-form__group">
              <input
                v-model="form.name"
                :class="{
                  'is-invalid': form.errors.has('name'),
                }"
                type="text"
                name="name"
                placeholder="Họ tên"
                class="auth-form__input"
              />
              <div
                class="text-danger"
                v-if="form.errors.has('name')"
                v-html="form.errors.get('name')"
              />
            </div>
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
            <div class="auth-form__group">
              <input
                v-model="form.password_confirmation"
                :class="{
                  'is-invalid': form.errors.has('password_confirmation'),
                }"
                type="password"
                name="password_confirmation"
                placeholder="Xác nhận mật khẩu"
                class="auth-form__input"
              />
              <div
                class="text-danger"
                v-if="form.errors.has('password_confirmation')"
                v-html="form.errors.get('password_confirmation')"
              />
            </div>
          </div>

          <div class="auth-form__controls">
            <span class="btn auth-form__controls-back">
              <router-link :to="{ name: 'login' }">Trở lại</router-link>
            </span>
            <button
              type="submit"
              class="btn btn-primary"
              style="cursor: pointer"
            >
              Đăng ký
            </button>
          </div>
        </form>
      </div>
    </div>
  </div>
</template>
<script>
export default {
  data: () => ({
    form: new Form({
      name: "",
      email: "",
      password: "",
      password_confirmation: "",
    }),
  }),
  methods: {
    async register() {
      // Submit the form.
      await this.form.post(route("register"));
      this.$router.push({ name: "login" });
    },
  },
};
</script>
<style scoped>
@import "../../../sass/auth.css";
</style>
