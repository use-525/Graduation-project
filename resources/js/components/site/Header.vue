<template>
  <header>
    <div class="container">
      <div class="row">
        <div
          class="col-3 col-sm-0 align-item-center column-mobile hide-on-tablet"
        >
          <svg
            class="icon-mobile"
            focusable="false"
            viewBox="0 0 24 24"
            aria-hidden="true"
          >
            <path
              d="M4 18h16c.55 0 1-.45 1-1s-.45-1-1-1H4c-.55 0-1 .45-1 1s.45 1 1 1zm0-5h16c.55 0 1-.45 1-1s-.45-1-1-1H4c-.55 0-1 .45-1 1s.45 1 1 1zM3 7c0 .55.45 1 1 1h16c.55 0 1-.45 1-1s-.45-1-1-1H4c-.55 0-1 .45-1 1z"
            ></path>
          </svg>
        </div>
        <div
          class="
            flexbox
            flex-1 flex-row-reverse
            col-4 col-sm-12
            login-and-setting
          "
          v-if="user"
        >
          <ul class="nav navbar-toolbar">
            <li class="dropdown dropdown-notification" v-if="notification.notifi_new">
              <router-link :to="{ name: 'notification' }" class="nav-link mt-2"
                ><i class="fa fa-bell-o rel" style="font-size: 18px;"><span
                    v-if="notification.notifi_new.length > 0"
                    class="notify-signal"
                  ></span></i
              ></router-link>
            </li>
            <li class="dropdown dropdown-user" v-if="user">
              <a class="nav-link dropdown-toggle link" data-toggle="dropdown">
                <img
                  v-if="user.image"
                  :src="'/' + user.image"
                  width="40"
                  height="40"
                  class="rounded-circle" />
                <img
                  v-else
                  :src="user.photo_url"
                  width="40"
                  height="40"
                  class="rounded-circle" />
                <span></span>{{ user.name
                }}<i class="fa fa-angle-down m-l-5"></i
              ></a>
              <ul class="dropdown-menu dropdown-menu-right">
                <router-link :to="{ name: 'profile' }" class="dropdown-item"
                  ><i class="fa fa-user mr-3"></i>Thông tin</router-link
                >
                <li class="dropdown-divider"></li>
                <router-link
                  :to="{ name: 'notification' }"
                  class="dropdown-item"
                  ><i class="ti-comments mr-3"></i>Thông báo</router-link
                >
                <li class="dropdown-divider"></li>
                <router-link
                  :to="{ name: 'homeDashboard' }"
                  class="dropdown-item"
                  ><i class="ti-layout-grid2-alt mr-3"></i>Bảng điều
                  khiển</router-link
                >
                <li class="dropdown-divider"></li>
                <router-link :to="{ name: 'settings' }" class="dropdown-item"
                  ><i class="ti-settings mr-3"></i>Cài đặt</router-link
                >
                <li class="dropdown-divider"></li>
                <a
                  class="dropdown-item"
                  href="javascript:;"
                  @click.prevent="logout"
                  ><i class="fa fa-power-off mr-3"></i>Logout</a
                >
              </ul>
            </li>
          </ul>
        </div>
        <div class="col-9 col-sm-12 login-and-setting" v-else>
          <router-link :to="{ name: 'login' }">
            <button class="login btn btn-md btn-success">Login</button>
          </router-link>
        </div>
      </div>
    </div>
  </header>
</template>

<script>
import { mapGetters } from "vuex";

export default {
  computed: mapGetters({
    user: "auth/user",
    notification: "notification/notification_by_user",
  }),

  created() {
    this.$store.dispatch("auth/fetchUser");
    this.$store.dispatch("notification/notificationByUser");
  },

  methods: {
    async logout() {
      // Log out the user.
      await this.$store.dispatch("auth/logout");
      // Redirect to login.
      this.$router.push({ name: "login" });
    },
  },
};
</script>

<style></style>
