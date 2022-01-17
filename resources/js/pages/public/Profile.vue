<template>
  <section class="content">
    <div class="page-content">
      <div class="container">
        <h3 class="pb-3 profile">Thông tin cá nhân</h3>
        <div class="main-body">
          <div class="row" v-if="auth">
            <div class="col-lg-4">
              <div class="card">
                <div class="card-body">
                  <div
                    class="d-flex flex-column align-items-center text-center"
                  >
                    <div class="user-image">
                      <img
                        width="100%"
                        v-if="auth.image"
                        :src="'/' + auth.image"
                        alt=""
                      />
                      <img width="100%" v-else :src="auth.photo_url" alt="" />
                    </div>
                    <div class="mt-3">
                      <h3>{{ auth.name }}</h3>
                      <p class="text-secondary mb-1" v-html="auth.roles[0].name"></p>
                      <p class="text-muted font-size-sm">
                        {{ auth.address }}
                      </p>
                    </div>
                  </div>
                  <hr class="my-4" />
                  <ul class="list-group list-group-flush">
                    <li
                      class="
                        list-group-item
                        d-flex
                        justify-content-between
                        align-items-center
                        flex-wrap
                      "
                    >
                      <h6 class="mb-0">
                        <svg
                          xmlns="http://www.w3.org/2000/svg"
                          width="24"
                          height="24"
                          viewBox="0 0 24 24"
                          fill="none"
                          stroke="currentColor"
                          stroke-width="2"
                          stroke-linecap="round"
                          stroke-linejoin="round"
                          class="feather feather-github me-2 icon-inline"
                        >
                          <path
                            d="M9 19c-5 1.5-5-2.5-7-3m14 6v-3.87a3.37 3.37 0 0 0-.94-2.61c3.14-.35 6.44-1.54 6.44-7A5.44 5.44 0 0 0 20 4.77 5.07 5.07 0 0 0 19.91 1S18.73.65 16 2.48a13.38 13.38 0 0 0-7 0C6.27.65 5.09 1 5.09 1A5.07 5.07 0 0 0 5 4.77a5.44 5.44 0 0 0-1.5 3.78c0 5.42 3.3 6.61 6.44 7A3.37 3.37 0 0 0 9 18.13V22"
                          ></path>
                        </svg>
                        Github
                      </h6>
                      <span class="text-secondary"
                        ><a :href="auth.github_url">{{ auth.github_url }}</a></span
                      >
                    </li>
                  </ul>
                </div>
              </div>
            </div>
            <div class="col-lg-8">
              <div class="card mb-4">
                <div class="card-body">
                  <div class="row mb-3">
                    <div class="col-sm-3">
                      <h6 class="mb-0">Họ và tên</h6>
                    </div>
                    <div class="col-sm-9 text-dark">
                      <h6>: {{ auth.name }}</h6>
                    </div>
                  </div>
                  <div class="row mb-3">
                    <div class="col-sm-3">
                      <h6 class="mb-0">Email</h6>
                    </div>
                    <div class="col-sm-9 text-dark">
                      <h6>: {{ auth.email }}</h6>
                    </div>
                  </div>
                  <div class="row mb-3">
                    <div class="col-sm-3">
                      <h6 class="mb-0">Số điện thoại</h6>
                    </div>
                    <div class="col-sm-9 text-dark">
                      <h6>: {{ auth.phone }}</h6>
                    </div>
                  </div>
                  <div class="row mb-3">
                    <div class="col-sm-3">
                      <h6 class="mb-0">Địa chỉ</h6>
                    </div>
                    <div class="col-sm-9 text-dark">
                      <h6>: {{ auth.address }}</h6>
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </section>
</template>

<script>
import { mapGetters } from "vuex";

export default {
  computed: mapGetters({
    auth: "auth/user",
  }),

  created() {
    this.$store.dispatch("auth/fetchUser");
  },
  methods: {},
};
</script>

<style scoped>
.content {
  margin-bottom: 40px;
  color: var(--black);
}
.container {
  font-family: "Poppins", sans-serif;
}
.profile {
  background: linear-gradient(to right, #6d2fff, #6f42c1);
  color: #fff;
  font-weight: 400;
  padding: 10px;
  padding-top: 15px;
  border-radius: 0.25rem;
}

.profile-share-customize {
  display: flex;
  justify-content: flex-end;
  padding-top: 24px;
  padding-bottom: 24px;
}

.btn-block {
  outline: none;
  border: none;
  height: 3.6rem;
  font-size: 1.2rem;
  font-weight: 500;
  border-radius: 4px;
  cursor: pointer;
  color: var(--white-grey);
  display: inline-block;
  box-sizing: border-box;
  transition: 0.3s;
  font-family: "Poppins", sans-serif;
  margin-top: 0px;
  min-width: 5rem;
}
.profile-share-customize button {
  min-width: 8rem;
}

.profile-share-customize .btn-share {
  margin-right: 16px;
}

.profile-share-customize .btn-customize {
  width: 12rem;
}

.btn-block:hover {
  border: 1px solid #8d99a7;
  box-shadow: 0 4px 6px -1px rgb(0 0 0 / 10%), 0 2px 4px -1px rgb(0 0 0 / 6%);
}

.block-style {
  margin-bottom: 16px;
  font-family: "Lato", sans-serif;
  padding: 16px;
  background-color: var(--background);
  border-radius: var(--border-radius-main);
  box-shadow: 0 5px 15px 0 #dedede;
}

.profile-user .user-image img {
  border-radius: var(--border-radius-main);
}

.profile-user .user-nickname {
  padding: 30px 0;
  color: var(--primary-color);
}

.profile-user .user-github {
  text-align: right;
}

.profile-user .user-github .github-icon {
  text-align: right;
  fill: var(--grey-color);
  width: 18px;
}

.skill-head {
  display: flex;
  justify-content: space-between;
  color: var(--black-bold);
}

.skill-head h3 {
  font-size: 1.8rem;
  color: var(--primary-color);
}

.btn-skill {
  font-family: "Poppins", sans-serif;
  background-color: var(--background-light);
  border: 1px solid var(--grey-color);
  padding: 8px 12px;
  padding-right: 0;
  border-radius: var(--border-radius-main);
  color: #fff;
  outline: none;
  display: inline-block;
  margin-top: 12px;
  margin-bottom: 4px;
  font-weight: 500;
  color: var(--black);
}

.btn-skill:hover {
  box-shadow: 0 5px 15px 0 #dedede;
}

.user-skill-wrapper span {
  display: inline-block;
  margin-left: 4px;
}

.icon-skill {
  margin-left: 8px;
}

.btn-skill span {
  display: inline-block;
  border-right: 1px solid #454f59;
  padding-right: 12px;
}

.skill-body h4 {
  font-size: 1.6rem;
}

.other-skill {
  margin-top: 26px;
}

.btn-add {
  margin-right: 4px;
}

.overlay {
  position: fixed;
  height: 100vh;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  background-color: rgba(0, 0, 0, 0.5);
  display: none;
}

.add-skill-form,
.edit-skill-form {
  position: fixed;
  width: 440px;
  min-height: 68%;
  top: 50%;
  left: 50%;
  transform: translate(-50%, -50%);
  background-color: var(--background-light);
  font-size: 1.6rem;
  color: var(--black);
  display: none;
  box-shadow: none;
}

.edit-skill-form {
  min-height: 10%;
}

.add-skill-form h5,
.edit-skill-form h5 {
  font-size: 1.6rem;
  color: var(--primary-color);
}

.exit-add-skill,
.exit-edit-skill {
  cursor: pointer;
  font-size: 20px;
}

.exit-add-skill:hover,
.exit-edit-skill:hover {
  fill: orangered;
}

.skill-form-wrap label {
  font-size: 1.2rem;
}

.skill-form-wrap {
  font-family: "Poppins", sans-serif;
}

.skill-form-wrap input {
  background: inherit;
  width: 100%;
  padding: 10px;
  color: var(--black);
  border: 1px solid #c9d0da;
  border-radius: var(--border-radius-main);
  margin-top: 6px;
  outline: none;
}

.skill-form-wrap input:focus {
  border: 1px solid #2a8ec7;
}

.skill-form-wrap .helper-text {
  font-size: 1rem;
}

.skill-list-add {
  margin-top: 16px;
  background: var(--background-light);
}

.skill-list-suggestions button {
  min-width: 8rem;
  margin: 8px 4px;
}

.btn-add-finish,
.btn-edit-finish {
  text-align: right;
}
.btn-add-finish button,
.btn-edit-finish button {
  height: 4.6rem;
  width: 9rem;
  margin-top: 16px;
}

.btn-add-finish button:hover,
.btn-edit-finish button:hover {
  background-color: #2a8ec7;
}

.icon-delete {
  font-size: 1.8rem;
  margin: 0;
}

.skill-item {
  padding: 12px 0;
  border-bottom: 1px solid #454f59;
}
</style>
