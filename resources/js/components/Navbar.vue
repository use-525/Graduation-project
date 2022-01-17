<template>
  <header class="header">
            <div class="page-brand">
                <router-link :to="{name: 'dashboard'}" class="link">
                    <span class="brand">Dev
                        <span class="brand-tip">POLY</span>
                    </span>
                    <span class="brand-mini">PL</span>
                </router-link>
            </div>
            <div class="flexbox flex-1">
                <!-- START TOP-LEFT TOOLBAR-->
                <ul class="nav navbar-toolbar">
                    <li>
                        <a class="nav-link sidebar-toggler js-sidebar-toggler"><i class="ti-menu"></i></a>
                    </li>
                    <li>
                        <router-link :to="{name: 'home'}" class="nav-link"><i class="ti-desktop mr-2"></i> Xem trang</router-link>
                    </li>
                </ul>
                <!-- END TOP-LEFT TOOLBAR-->
                <!-- START TOP-RIGHT TOOLBAR-->
                <ul class="nav navbar-toolbar">
                    <li class="dropdown dropdown-notification" v-if="notification.notifi_new">
                        <a class="nav-link dropdown-toggle" data-toggle="dropdown"><i class="fa fa-bell-o rel" ><span v-if="notification.notifi_new.length>0" class="notify-signal"></span></i></a>
                        <ul class="dropdown-menu dropdown-menu-right dropdown-menu-media">
                            <li class="dropdown-menu-header">
                                <div>
                                    <span><strong>{{notification.notifi_new.length}} </strong> Thông báo mới</span>
                                    <router-link :to="{ name: 'admin.notification' }" class="pull-right">Xem tất cả</router-link>
                                </div>
                            </li>
                            <li class="list-group list-group-divider scroller" data-height="240px" data-color="#71808f">
                                <div>
                                    <a class="list-group-item" v-for="noti in notification.notifi_new" :key="noti.id">
                                        <div class="media">
                                            <div class="media-img">
                                                <span class="badge badge-success badge-big"><i class="fa fa-user"></i></span>
                                            </div>
                                            <div class="media-body">
                                                <div class="font-13">{{noti.title}}</div><small class="text-muted">{{noti.time}}</small></div>
                                        </div>
                                    </a>
                                </div>
                            </li>
                        </ul>
                    </li>
                    <li class="dropdown dropdown-user" v-if="user">
                        <a class="nav-link dropdown-toggle link" data-toggle="dropdown">
                            <img v-if="user.image" :src="'/'+user.image"  width="30" height="30"/>
                            <img v-else :src="user.photo_url"  width="30" height="30"/>
                            <span></span>{{user.name}}<i class="fa fa-angle-down m-l-5"></i></a>
                        <ul class="dropdown-menu dropdown-menu-right">
                            <router-link :to="{ name: 'admin.profile' }" class="dropdown-item"><i class="fa fa-user mr-3"></i>Hồ sơ</router-link>
                            <router-link :to="{ name: 'admin.notification' }" class="dropdown-item"><i class="ti-comments mr-3"></i>Thông báo</router-link>
                            <li class="dropdown-divider"></li>
                            <a class="dropdown-item" href="javascript:;" @click.prevent="logout"><i class="fa fa-power-off"></i>Đăng xuất</a>
                        </ul>
                    </li>
                </ul>
                <!-- END TOP-RIGHT TOOLBAR-->
            </div>
        </header>
</template>

<script>
import { mapGetters } from 'vuex'
export default {
  name: 'navbar',
   props: {
        user: {},
    },
    computed: mapGetters({
      notification: 'notification/notification_by_user'
    }),
    created () {
    this.$store.dispatch('notification/notificationByUser');
    
    },
  methods: {
    async logout () {
      // Log out the user.
      await this.$store.dispatch('auth/logout')
      // Redirect to login.
     this.$router.push({ name: 'admin.login' })
    }
  }
}
</script>
