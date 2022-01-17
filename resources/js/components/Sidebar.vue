<template>
 <nav class="page-sidebar" id="sidebar">
            <div id="sidebar-collapse">
                <div class="admin-block d-flex" v-if="user">
                    <div>
                        <img v-if="user.image" :src="'/'+user.image" width="45px" />
                        <img v-else :src="user.photo_url" width="45px" />
                    </div>
                    <div class="admin-info">
                        <div class="font-strong">{{user.name}}</div><small>{{user.roles[0].name}}</small>
                        </div>
                </div>
                <ul class="side-menu metismenu">
                    <li>
                         <router-link :to="{name: 'dashboard'}" class="nav-link active">
                             <i class="sidebar-item-icon fa fa-th-large"></i>
                            <span class="nav-label">Tổng quan</span>
                         </router-link>
                    </li>
                    <li class="heading">Chức năng</li>
                    <li>
                        <a href="javascript:;"><i class="sidebar-item-icon ti-user"></i>
                            <span class="nav-label">Tài khoản</span><i class="fa fa-angle-left arrow"></i></a>
                        <ul class="nav-2-level collapse">
                            <li>
                                <router-link :to="{name: 'users'}" class="nav-link">
                                   Danh sách tài khoản
                                    </router-link>
                            </li>
                            <li>
                                 <router-link :to="{name: 'roles'}" class="nav-link">
                                   Vai trò
                                    </router-link>
                            </li>
                            <li>
                                <router-link :to="{name: 'permissions'}" class="nav-link">
                                   Quyền hạn
                                    </router-link>
                            </li>
                            <li>
                                <router-link v-if="$can('create users')" :to="{name: 'add.user'}" class="nav-link">
                                   Thêm tài khoản
                                    </router-link>
                            </li>
                        </ul>
                    </li>
                    <li>
                        <a href="javascript:;"><i class="sidebar-item-icon fa fa-table"></i>
                            <span class="nav-label">Mentor</span><i class="fa fa-angle-left arrow"></i></a>
                        <ul class="nav-2-level collapse">
                            <li>
                                <router-link :to="{name: 'mentors'}" class="nav-link">
                                Danh sách Mentor
                                </router-link>
                            </li>
                            <li>
                                <router-link v-if="$can('create mentors')" :to="{name: 'add.mentor'}" class="nav-link">
                                Thêm Mentor
                                </router-link>
                            </li>
                        </ul>
                    </li>
                    <li>
                        <a href="javascript:;"><i class="sidebar-item-icon fa fa-table"></i>
                            <span class="nav-label">Danh mục</span><i class="fa fa-angle-left arrow"></i></a>
                        <ul class="nav-2-level collapse">
                            <li>
                                <router-link :to="{name: 'challengecategories'}" class="nav-link">
                                Danh sách danh mục
                                </router-link>
                            </li>
                            <li>
                                <router-link v-if="$can('create categories')" :to="{name: 'add.challengecategory'}" class="nav-link">
                                Thêm danh mục
                                </router-link>
                            </li>
                        </ul>
                    </li>
                    <li>
                        <a href="javascript:;"><i class="sidebar-item-icon fa fa-bar-chart"></i>
                            <span class="nav-label">Thử thách</span><i class="fa fa-angle-left arrow"></i></a>
                        <ul class="nav-2-level collapse">
                            <li>
                                <router-link :to="{name: 'challenges'}" class="nav-link">
                                Danh sách thử thách
                                </router-link>
                            </li>
                            <li>
                               <router-link v-if="$can('create challenges')" :to="{name: 'add.challenge'}" class="nav-link">
                                Thêm thử thách
                                </router-link>
                            </li>
                        </ul>
                    </li>
                    <li>
                        <router-link :to="{name: 'solutions'}" class="nav-link">
                            <i class="sidebar-item-icon ti-light-bulb"></i>
                           <span class="nav-label">Giải pháp</span>
                        </router-link>
                    </li>
                    <li>
                        <router-link :to="{name: 'feedbacks'}" class="nav-link">
                            <i class="sidebar-item-icon ti-comment-alt"></i>
                                <span class="nav-label">Bình luận</span>
                        </router-link>
                    </li>
                    
                    <li class="heading">PAGES</li>
                     <li>
                        <router-link :to="{name: 'admin.private-chat'}" class="nav-link">
                            <i class="sidebar-item-icon ti-comments"></i>
                                <span class="nav-label">Trao đổi</span>
                        </router-link>
                    </li>
                    <li>
                       <router-link :to="{name: 'admin.orders'}" class="nav-link">
                            <i class="sidebar-item-icon ti-receipt"></i>
                                <span class="nav-label">Hoá đơn</span>
                        </router-link>
                    </li>
                    <li>
                      <router-link :to="{name: 'admin.upgrades'}" class="nav-link">
                            <i class="sidebar-item-icon ti-package"></i>
                                <span class="nav-label">Gói vip</span>
                        </router-link>
                    </li>
                    <li>
                        <a href="javascript:;"><i class="sidebar-item-icon ti-comments"></i>
                            <span class="nav-label">Thông báo</span><i class="fa fa-angle-left arrow"></i></a>
                        <ul class="nav-2-level collapse">
                            <li>
                                <router-link :to="{name: 'admin.notifications'}" class="nav-link">
                                Danh sách
                                </router-link>
                            </li>
                            <li>
                               <router-link v-if="$can('create notifications')" :to="{name: 'add.notification'}" class="nav-link">
                                Thêm thông báo
                                </router-link>
                            </li>
                        </ul>
                    </li>
                </ul>
            </div>
        </nav>
</template>

<script>

export default {
  name: 'sidebar',
   props: {
        user: {},
    },
}

</script>
