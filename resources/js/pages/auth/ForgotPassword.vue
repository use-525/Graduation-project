<template>
  <div class="content-login">
    <div class="brand">
      <a class="link webtitle" href="index.html">DEVPOLY</a>
    </div>
    <form
      class="mb-3"
      @submit.prevent="forgot"
      @keydown="form.onKeydown($event)"
    >
      <div ref="form">
        <h3 class="pb-3">Quên mật khẩu</h3>
        <p class="">
          Nhập địa chỉ email của bạn vào bên dưới và chúng tôi sẽ gửi cho bạn
          hướng dẫn đặt lại mật khẩu.
        </p>
        <div class="form-group">
          <input
            type="email"
            class="form-control"
            name="email"
            autocomplete
            v-model="form.email"
            :class="{ 'is-invalid': form.errors.has('email') }"
            placeholder="Nhập địa chỉ email"
          />
          <div
            class="text-danger"
            v-if="form.errors.has('email')"
            v-html="form.errors.get('email')"
          />
        </div>
        <div class="form-group">
          <div class="row">
            <div class="col-6">
              <span class="btn auth-form__controls-back">
                <router-link :to="{ name: 'login' }">Trở lại</router-link>
              </span>
            </div>
            <div class="col-6">
              <button class="btn btn-info btn-block" type="submit">
                Đặt lại mật khẩu
              </button>
            </div>
          </div>
        </div>
      </div>
      <p class="m-b-20 d-none" ref="noti">
        Chúng tôi đã gửi một liên kết đến email của bạn. Vui lòng kiểm tra email
        để đặt lại mật khẩu!
      </p>
    </form>
  </div>
</template>
<style scoped>
@import "../../../../public/assets/css/pages/auth-light.css";
</style>
<script>
export default {
  data: () => ({
    form: new Form({
      email: "",
    }),
  }),
  methods: {
    async forgot() {
      // Submit the form.
      await this.form.post(route("user.forgot_pass")).then((response) => {
        var result = response.data;
        this.$refs.form.classList.add("d-none");
        this.$refs.noti.classList.remove("d-none");
      });
    },
  },
};
</script>

<style scoped>
.webtitle {
  color: #111;
  font-family: "Helvetica Neue", sans-serif;
  font-size: 40px;
  font-weight: bold;
  letter-spacing: -1px;
  line-height: 1;
  text-align: center;
  text-transform: uppercase;
  background: linear-gradient(to right, #30cfd0 0%, #330867 100%);
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent;
}
</style>