<template>
  <section class="content">
    <div class="container">
      <div class="step-list">
        <div class="row">
          <div class="col-md-12">
            <h1>Premium</h1>
          </div>
        </div>

        <div class="row content-list">
          <table class="table">
            <thead>
              <tr>
                <th scope="col">Order #</th>
                <th scope="col"></th>
              </tr>
            </thead>
            <tbody>
              <tr>
                <th scope="row">Upgrade</th>
                <td>Mark</td>
              </tr>
              <tr>
                <th scope="row">Số tiền</th>
                <td>Jacob</td>
              </tr>
              <tr>
                <th scope="row">Mã đơn hàng</th>
                <td>@twitter</td>
              </tr>
              <tr>
                <th scope="row">Momo Request Id</th>
                <td>@twitter</td>
              </tr>
              <tr>
                <th scope="row">Mã giao dịch</th>
                <td>@twitter</td>
              </tr>
              <tr>
                <th scope="row">Hình thức thanh toán</th>
                <td>@twitter</td>
              </tr>
            </tbody>
          </table>
        </div>
      </div>
    </div>
  </section>
</template>
<script>
import { mapGetters } from "vuex";
export default {
  computed: mapGetters({
    data: "challenge/challenge",
  }),
  created() {
    this.$store.dispatch("challenge/fet_One_Data", this.$route.params.slug);
  },
  methods: {},
};
</script>

<style lang="scss">
@import "../../../sass/home.scss";
</style>
