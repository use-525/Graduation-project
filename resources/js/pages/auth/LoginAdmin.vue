<template>
     <div class="content-login">
        <div class="brand">
            <a class="link" href="">DevPOLY</a>
        </div>
        <form @submit.prevent="login" @keydown="form.onKeydown($event)">
            <h2 class="login-title">Đăng nhập</h2>
            <div class="form-group">
                <div class="input-group-icon right">
                    <div class="input-icon"><i class="fa fa-envelope"></i></div>
                    <input type="email" class="form-control" name="email" autocomplete v-model="form.email" :class="{ 'is-invalid': form.errors.has('email') }" placeholder="Enter email">
                    <div class="text-danger" v-if="form.errors.has('email')" v-html="form.errors.get('email')" />
                </div>
            </div>
            <div class="form-group">
                <div class="input-group-icon right">
                    <div class="input-icon"><i class="fa fa-lock font-16"></i></div>
                    <input class="form-control" type="password" name="password" :class="{ 'is-invalid': form.errors.has('password') }" v-model="form.password" placeholder="Password">
                    <div class="text-danger" v-if="form.errors.has('password')" v-html="form.errors.get('password')" />
                </div>
            </div>
            <div class="form-group d-flex justify-content-between">
                <label class="ui-checkbox ui-checkbox-info">
                    <input type="checkbox" v-model="form.remember" name="remember">
                    <span class="input-span"></span>Nhớ tôi</label> 
                <router-link :to="{ name: 'forgot.pass' }">Quên mật khẩu?</router-link>
            </div>
            <div class="form-group">
                <button class="btn btn-info btn-block" type="submit">Đăng nhập</button>
            </div>
        </form>
    </div>
</template>
<style scoped>
@import '../../../../public/assets/css/pages/auth-light.css';
</style>
<script>
import Cookies from 'js-cookie'
export default {
  data: () => ({
    form: new Form({
      email: '',
      password: '',
      remember: false
    }),
  }),
  methods: {
    async login () {
      // Submit the form.
      const { data } = await this.form.post(route('login'))
      // Save the token.
      this.$store.dispatch('auth/saveToken', {
        token: data.access_token,
        remember: this.form.remember
      })
      // Fetch the user.
    //  await this.$store.dispatch('auth/fetchUser')
      // Redirect home.
      this.redirect()
    },
    redirect () {
      const intendedUrl = Cookies.get('intended_url')
      if (intendedUrl) {
        Cookies.remove('intended_url')
        this.$router.push({ path: intendedUrl })
      } else {
        this.$router.push({ name: 'dashboard' })
      }
    }
  }  
}
</script>
