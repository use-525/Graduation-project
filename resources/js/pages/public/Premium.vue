<template>
  <section class="content">
    <div class="container">
      <div class="step-list">
        <div class="row">
          <div class="col-md-12 mb-4">
            <h1>Nâng cấp VIP</h1>
          </div>
        </div>

        <div class="row row-cols-1 row-cols-lg-3">
          
          <div
            class="pricing col-lg-3 mb-5 mr-5 mb-lg-0"
            v-for="upgrade in upgrades"
            :key="upgrade.id"
          >
            <div class="p-4 rounded-lg shadow">
              <h1 class="h6 text-uppercase font-weight-bold mb-4">
                {{ upgrade.name }}
              </h1>
              <h2 class="h1 font-weight-bold">{{ upgrade.price }} VNĐ</h2>
              <div class="custom-separator my-3 mx-auto"></div>
              <ul
                class="
                  list-unstyled
                  my-5
                  text-small text-left
                  font-weight-normal
                "
              >
                <li class="mb-3">
                  <p v-html="upgrade.description"></p>
                </li>
              </ul>
              <router-link
                :to="{ name: 'payment', params: { upgrade_id: upgrade.id } }"
                ><button
                  type="button"
                  class="btn buynow btn-block p-2 shadow rounded-pill"
                >
                  Nâng cấp ngay
                </button></router-link
              >
            </div>
          </div>
          <!-- END -->
        </div>
      </div>
    </div>
  </section>
</template>
<script>
import { mapGetters } from "vuex";
export default {
  computed: mapGetters({
    upgrades: "upgrade/all",
  }),
  created() {
    this.$store.dispatch("upgrade/all");
  },
  methods: {},
};
</script>

<style lang="scss">
@import "../../../sass/home.scss";
</style>
