<template>
  <section class="content">
    <div class="container">
      <div class="row">
        <div class="col-12">
          <h2 class="pb-4">Cài đặt tài khoản</h2>
          <form
            @submit.prevent="updateProfile"
            @keydown="form.onKeydown($event)"
            v-if="auth"
            class="form-horizontal"
          >
            <div class="form-group row">
              <label for="" class="col-sm-2 col-form-label"
                >Tên đăng nhập <span class="text-danger">*</span>:</label
              >
              <div class="col-sm-10">
                <input
                  type="text"
                  v-model="auth.username"
                  :class="{ 'is-invalid': form.errors.has('username') }"
                  class="form-control"
                  name="username"
                  placeholder="Enter username"
                />
                <div
                  class="text-danger"
                  v-if="form.errors.has('username')"
                  v-html="form.errors.get('username')"
                />
              </div>
            </div>
            <div class="form-group row">
              <label for="" class="col-sm-2 col-form-label">Họ và tên <span class="text-danger">*</span>:</label>
              <div class="col-sm-10">
                <input
                  type="text"
                  v-model="auth.name"
                  :class="{ 'is-invalid': form.errors.has('name') }"
                  class="form-control"
                  name="username"
                  placeholder="Enter name"
                />
                <div
                  class="text-danger"
                  v-if="form.errors.has('name')"
                  v-html="form.errors.get('name')"
                />
              </div>
            </div>
            <div class="form-group row">
              <label for="" class="col-sm-2 col-form-label">Email <span class="text-danger">*</span>:</label>
              <div class="col-sm-10">
                <input
                  type="email"
                  v-model="auth.email"
                  :class="{ 'is-invalid': form.errors.has('email') }"
                  class="form-control"
                  name="email"
                  placeholder="Enter email"
                />
                <div
                  class="text-danger"
                  v-if="form.errors.has('email')"
                  v-html="form.errors.get('email')"
                />
              </div>
            </div>
            <div class="form-group row">
              <label for="" class="col-sm-2 col-form-label">Ảnh:</label>
              <div class="col-sm-10">
                <input
                  type="file"
                  @change="upload($event)"
                  :class="{ 'is-invalid': form.errors.has('image') }"
                  class="form-control"
                  name="image"
                />
                <div
                  class="text-danger"
                  v-if="form.errors.has('image')"
                  v-html="form.errors.get('image')"
                />
                <img
                  id="previewImg"
                  :src="'/' + auth.image"
                  alt=""
                  width="200"
                />
              </div>
            </div>

            <div class="form-group row">
              <label for="" class="col-sm-2 col-form-label">Địa chỉ:</label>
              <div class="col-sm-10">
                <input
                  type="text"
                  class="form-control"
                  v-model="auth.address"
                  :class="{ 'is-invalid': form.errors.has('address') }"
                  placeholder="Enter address"
                />
                <div
                  class="text-danger"
                  v-if="form.errors.has('address')"
                  v-html="form.errors.get('address')"
                />
              </div>
            </div>
            <div class="form-group row">
              <label for="" class="col-sm-2 col-form-label"
                >Số điện thoại <span class="text-danger">*</span>:</label
              >
              <div class="col-sm-10">
                <input
                  type="text"
                  class="form-control"
                  :class="{ 'is-invalid': form.errors.has('phone') }"
                  v-model="auth.phone"
                  placeholder="Enter phone"
                />
                <div
                  class="text-danger"
                  v-if="form.errors.has('phone')"
                  v-html="form.errors.get('phone')"
                />
              </div>
            </div>
            <div class="form-group row">
              <label for="" class="col-sm-2 col-form-label">Giới tính:</label>
              <div class="col-md-10">
                <label class="ui-radio ui-radio-primary mr-3" for="male">
                  <input
                    type="radio"
                    name="gender"
                    :value="1"
                    id="male"
                    v-model="auth.gender"
                  />
                  <span class="input-span"></span>Nam</label
                >
                <label class="ui-radio ui-radio-primary" for="female">
                  <input
                    type="radio"
                    name="gender"
                    :value="0"
                    id="female"
                    v-model="auth.gender"
                  />
                  <span class="input-span"></span>Nữ</label
                >
                <div
                  class="text-danger"
                  v-if="form.errors.has('gender')"
                  v-html="form.errors.get('gender')"
                />
              </div>
            </div>
            <div class="form-group row">
              <label for="" class="col-sm-2 col-form-label">Github:</label>
              <div class="col-sm-10">
                <p v-if="auth.github_url" v-html="auth.github_url"></p>
                <p v-else>Link github</p>
              </div>
            </div>
            <div class="form-group row">
              <div class="col-sm-10 ml-sm-auto">
                <button class="btn btn-info" type="submit">Cập nhật</button>
              </div>
            </div>
          </form>
          <h3 class="mt-2">Tạo mật khẩu</h3>
          <form @submit.prevent="createPassword"
            @keydown="form.onKeydown($event)"
            v-if="auth"
            class="form-horizontal">
            <div class="form-group row">
              <label for="" class="col-sm-2 col-form-label"
                >Mật khẩu <span class="text-danger">*</span>:</label
              >
              <div class="col-sm-10">
                <input
                  type="password"
                  v-model="formPass.password"
                  :class="{ 'is-invalid': formPass.errors.has('password') }"
                  class="form-control"
                  placeholder="Nhập mật khẩu"
                />
                <div
                  class="text-danger"
                  v-if="formPass.errors.has('password')"
                  v-html="formPass.errors.get('password')"
                />
              </div>
            </div>
            <div class="form-group row">
              <label for="" class="col-sm-2 col-form-label"
                >Xác nhận mật khẩu <span class="text-danger">*</span>:</label
              >
              <div class="col-sm-10">
                <input
                  type="password"
                  v-model="formPass.confirm_password"
                  :class="{ 'is-invalid': formPass.errors.has('confirm_password') }"
                  class="form-control"
                  placeholder="Nhập mật khẩu"
                />
                <div
                  class="text-danger"
                  v-if="formPass.errors.has('confirm_password')"
                  v-html="formPass.errors.get('confirm_password')"
                />
              </div>
            </div>
            <div class="form-group row">
              <div class="col-sm-10 ml-sm-auto">
                <button class="btn btn-info" type="submit">Cập nhật</button>
              </div>
            </div>
          </form>
        </div>
      </div>
    </div>
  </section>
</template>

<script>
import { mapGetters } from "vuex";

export default {
  data: () => ({
    form: new Form({
      username: "",
      name: "",
      email: "",
      image: "",
      address: "",
      password: "",
      phone: "",
      gender: "",
    }),
    formPass: new Form({
      password: "",
      confirm_password: "",
    }),
  }),
  computed: mapGetters({
    auth: "auth/user",
  }),

  created() {
    this.$store.dispatch("auth/fetchUser");
  },
  methods: {
    upload(event) {
      var file = (this.form.image = event.target.files[0]);
      if (file) {
        var reader = new FileReader();
        reader.onload = function () {
          $("#previewImg").attr("src", reader.result);
        };
        reader.readAsDataURL(file);
      }
    },
    async updateProfile() {
      this.form.name = this.auth.name;
      this.form.username = this.auth.username;
      this.form.email = this.auth.email;
      this.form.address = this.auth.address;
      this.form.phone = this.auth.phone;
      this.form.gender = this.auth.gender;
      await this.form
        .post(route("profile.user", this.auth.id))
        .then((response) => {
          if (response.data.status == "success") {
            Swal.fire("Đã lưu", "Cập nhật tài khoản thành công", "success");
          }
        })
        .catch(() => {
          Swal.fire({
            icon: "error",
            title: "Oops...",
            text: "Đã xảy ra lỗi!",
          });
        });
    },
    createPassword() {
      this.formPass
        .post(route("create.password", this.auth.id))
        .then((response) => {
          if (response.data.status == "success") {
            this.$router.push({ name: "users" });
            Swal.fire("Đã lưu", "Cập nhật mật khẩu thành công", "success");
          }
        })
        .catch(() => {
          Swal.fire({
            icon: "error",
            title: "Oops...",
            text: "Đã xảy ra lỗi!",
          });
        });
    },
  },
};
</script>

<style scoped>
</style>