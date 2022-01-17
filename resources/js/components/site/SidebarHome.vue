<template>
  <aside class="sidebar hide-on-mobile">
    <div class="d-flex justify-content-between align-item-center">
      <div class="logo">
        <router-link :to="{ name: 'home' }">
          <img class="hide-on-destop" src="/images/logo.png" width="150" />

          <img
            class="hide-on-mobile hide-on-destop-large"
            src="/images/logo-icon.png"
            width="40"
          />
          <!-- logo tablet -->
          <img
            class="hide-on-mobile hide-on-destop-large hide-on-destop"
            src="/images/logo.png"
            width="150"
          />
        </router-link>
      </div>
      <div>
        <svg
          class="icon-hide-sidebar hide-on-tablet"
          focusable="false"
          viewBox="0 0 24 24"
          aria-hidden="true"
        >
          <path
            d="M18.3 5.71a.9959.9959 0 00-1.41 0L12 10.59 7.11 5.7a.9959.9959 0 00-1.41 0c-.39.39-.39 1.02 0 1.41L10.59 12 5.7 16.89c-.39.39-.39 1.02 0 1.41.39.39 1.02.39 1.41 0L12 13.41l4.89 4.89c.39.39 1.02.39 1.41 0 .39-.39.39-1.02 0-1.41L13.41 12l4.89-4.89c.38-.38.38-1.02 0-1.4z"
          ></path>
        </svg>
      </div>
    </div>

    <nav class="nav">
      <ul>
        <li>
          <router-link :to="{ name: 'home' }">
            <i class="ti-home mr-2"></i>
            <span class="hide-on-destop">Trang chủ</span></router-link
          >
        </li>
        <li v-if="auth">
          <router-link :to="{ name: 'homeDashboard' }">
            <i class="ti-layout-grid2-alt mr-2"></i>
            <span class="hide-on-destop">Tổng quan</span></router-link
          >
        </li>
        <li>
          <a href="https://www.youtube.com/channel/UCr3kDr9QiZ7VbZxAKh57OFQ" target="_blank">
            <i class="ti-book mr-2"></i>
            <span class="hide-on-destop">Học tập</span></a
          >
        </li>
        <li>
          <router-link :to="{ name: 'chat' }">
            <i class="ti-comments mr-2"></i>
            <span class="hide-on-destop">Trao đổi hỏi đáp</span></router-link>
        </li>
        <li v-if="auth">
          <router-link :to="{ name: 'premium' }">
            <i class="ti-credit-card mr-2"></i>
            <span class="hide-on-destop">Nâng cấp VIP</span></router-link>
        </li>
        <li>
          <router-link :to="{ name: 'faq' }">
            <i class="ti-help-alt mr-2"></i>
            <span class="hide-on-destop">FAQ</span></router-link>
        </li>
        <!-- <li><a href="#">
                        <svg class="icon-cate" focusable="false" viewBox="0 0 24 24" aria-hidden="true"><path d="M20 6h-1v8c0 .55-.45 1-1 1H6v1c0 1.1.9 2 2 2h10l4 4V8c0-1.1-.9-2-2-2zm-3 5V4c0-1.1-.9-2-2-2H4c-1.1 0-2 .9-2 2v13l4-4h9c1.1 0 2-.9 2-2z"></path></svg>
                        <span class="hide-on-destop">Forum</span></a></li> -->
      </ul>
    </nav>
  </aside>
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
};
</script>

<style>
.sidebar {
  box-shadow: 0 1px 3px rgba(0, 0, 0, 0.12), 0 1px 2px rgba(0, 0, 0, 0.24);
}
</style>
