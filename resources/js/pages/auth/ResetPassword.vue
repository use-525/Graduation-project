<template>
     <div class="content-login">
        <div class="brand">
            <a class="link" href="index.html">DevPOLY</a>
        </div>
        <form @submit.prevent="reset" @keydown="form.onKeydown($event)">
                <h3 class="m-t-10 m-b-10">Đặt lại mật khẩu</h3>
                <div class="form-group">
                    <input class="form-control" type="password" name="password" :class="{ 'is-invalid': form.errors.has('password') }" v-model="form.password" placeholder="Mật khẩu">
                    <div class="text-danger" v-if="form.errors.has('password')" v-html="form.errors.get('password')" />
                </div>
                <div class="form-group">
                    <input class="form-control" type="password" name="password_confirmation" :class="{ 'is-invalid': form.errors.has('password_confirmation') }" v-model="form.password_confirmation" placeholder="Xác nhận mật khẩu">
                    <div class="text-danger" v-if="form.errors.has('password_confirmation')" v-html="form.errors.get('password_confirmation')" />
                </div>
                <div class="form-group">
                    <button class="btn btn-info btn-block" type="submit">Đặt lại mật khẩu</button>
                </div>
        </form>
    </div>
</template>
<style scoped>
@import '../../../../public/assets/css/pages/auth-light.css';
@import "../../../sass/home.scss";
</style>
<script>
export default {
    data: () => ({
    form: new Form({
      password_confirmation: '',
      password:'',
      token:''
    }),
  }),
  created: function () {
   
    this.checkTokenResset();
  },
 methods: {
    async reset () {
      // Submit the form.
      this.form.token= this.$route.params.token;
       await this.form.post(route('password.update'));
        this.$router.push({ name: 'login' })
    },
    checkTokenResset(){
        axios.get(route('password.reset',this.$route.params.token))
        .then(response => {
          var result = response.data.data;
        })
        // eslint-disable-next-line
        .catch(errors => {
            this.$router.push({ name: 'home' })
              Swal.fire({
              icon: "error",
              title: "Oops...",
              text: "Mã token đã hết hạn!",
            });
        })
    }
  }  
}
</script>