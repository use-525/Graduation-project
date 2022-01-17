<template>
  <div class="content-wrapper">
    <!-- START PAGE CONTENT-->
    <div class="page-heading row">
      <breadcrumb :title="title" class="col-6"></breadcrumb>
      <router-link :to="{ name: 'add.order' }" class="col-6 text-right mt-5"
        ><button type="button" class="btn btn-primary">
          Add New
        </button></router-link
      >
    </div>
    <div class="page-content fade-in-up">
      <div class="ibox">
        <div class="ibox-head">
          <div class="ibox-title">{{ title }}</div>
        </div>
        <div class="ibox-body">
          <form
            @submit.prevent="addOrder"
            @keydown="form.onKeydown($event)"
            class="form-horizontal"
          >
            <div class="form-group row">
              <label class="col-sm-2 col-form-label">Gói sử dụng <span class="text-danger">*</span> : </label>
              <div class="col-sm-10">
                <select
                v-if="upgrades != null"
                  v-model="form.upgrade_id"
                  :class="{ 'is-invalid': form.errors.has('upgrade_id') }"
                  type="text"
                  name="upgrade_id"
                  class="form-control"
                  placeholder="Gói sử dụng"
                >
                  <option v-for="upgrade in upgrades" :key="upgrade.id" :value="upgrade.id">{{upgrade.name}}</option>
                </select>
                <div
                  class="text-danger"
                  v-if="form.errors.has('upgrade_id')"
                  v-html="form.errors.get('upgrade_id')"
                ></div>
              </div>
            </div>
            <div class="form-group row">
              <label class="col-sm-2 col-form-label">Email User <span class="text-danger">*</span> : </label>
              <div class="col-sm-10">
                <input
                  type="text"
                  class="form-control"
                  placeholder="Email Người Dùng"
                  name="email_user"
                  v-model="form.email_user"
                  :class="{
                    'is-invalid': form.errors.has('email_user'),
                  }"
                />
                <div
                  class="text-danger"
                  v-if="form.errors.has('email_user')"
                  v-html="form.errors.get('email_user')"
                />
              </div>
            </div>

            <div class="form-group row">
              <label class="col-sm-2 col-form-label">Trạng thái <span class="text-danger">*</span> : </label>
              <div class="col-sm-10">
                <select
                  v-model="form.status"
                  :class="{ 'is-invalid': form.errors.has('status') }"
                  type="text"
                  name="status"
                  class="form-control"
                  placeholder="Enter status"
                >
                  <option selected value="0">Chờ Thanh Toán</option>
                  <option value="1">Thành Công</option>
                  <option value="2">Lỗi</option>
                </select>
                <div
                  class="text-danger"
                  v-if="form.errors.has('status')"
                  v-html="form.errors.get('status')"
                ></div>
              </div>
            </div>

            <div class="form-group row">
              <div class="col-sm-10 ml-sm-auto">
                <button class="btn btn-info" type="submit">Gửi</button>
              </div>
            </div>
          </form>
        </div>
      </div>
    </div>
    <Footer></Footer>
  </div>
</template>

<script>
import Footer from "../../../components/AdminFooter.vue";
import TableButton from "../../../components/TableButton.vue";

export default {
  data: () => ({
    form: new Form({
      upgrade_id: "",
      status: "",
      email_user: "",
    }),
    title: "Tạo Order",
    tableProps: {
      search: "",
      length: 10,
      column: "id",
      dir: "asc",
    },
    upgrades: {},
  }),
  components: {
    Footer,
    TableButton,
  },
  created() {
    this.getUpgrader();
  },
  methods: {
    async getUpgrader(url = route("upgrades"), options = this.tableProps) {
      await axios
        .get(url, {
          params: options,
        })
        .then((response) => {
          this.upgrades = response.data.data;
        })
        .catch((errors) => {
        });
    },
        async addOrder() {
          if(Permissions.indexOf('create orders') == -1){
            Swal.fire({
              icon: 'error',
              title: 'Oops...',
              text: 'Bạn không có quyền thêm danh mục!',
              })
            }else{
            await this.form
              .post(route("create.order"))
              .then((response) => {
                if (response.data.status == "success") {
                  this.$router.push({ name: "admin.orders" });
                  Swal.fire("Created", "Challenge created Successfully", "success");
                }
              })
              .catch(() => {
                Swal.fire({
                  icon: "error",
                  title: "Oops...",
                  text: "Đã  xảy ra lỗi!",
                });
              });
            }
    },
  },
};
</script>

<style>
</style>
