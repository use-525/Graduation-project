<template>
     <div class="content-wrapper">
        <!-- START PAGE CONTENT-->
        <div class="page-heading">
            <breadcrumb :title='title'></breadcrumb>
        </div>
        <div class="page-content fade-in-up">
            <div class="ibox">
                <div class="ibox-head">
                    <div class="ibox-title">{{title}}</div>
                   
                </div>
                <div class="ibox-body list-group list-group-divider">
                   <div class="container">
                         <a class="list-group-item" v-for="(noti,index) in notification.notification" :key="index">
                            <div class="media" @click="markRead(noti.id,index,noti.is_read)">
                                <div class="media-img">
                                    <span class="badge badge-success badge-big"><i class="fa fa-user"></i></span>
                                </div>
                                <div class="media-body">
                                    <div class="font-13" v-if="noti.is_read==0"><strong>{{noti.title}}</strong></div>
                                    <div class="font-13" v-else-if="noti.is_read==1">{{noti.title}}</div>
                                    <small class="text-muted">{{noti.time}}</small>
                                </div>
                            </div>
                            <div class="font-13 d-none" ref="content" v-html="noti.content"></div>
                        </a>
                    </div>
                </div>
            </div>
            
        </div>
        <!-- END PAGE CONTENT-->
        <Footer></Footer>
    </div>
</template>

<script>
import Footer from '../../../components/AdminFooter.vue';
import { mapGetters } from 'vuex'

export default {
     data:() => ({
    title: 'Thông báo',

    }),
    components:{
      Footer
    },
   computed: mapGetters({
      notification: 'notification/notification_by_user'
    }),
    created () {
    this.$store.dispatch('notification/notificationByUser');
    },
    methods: {
       
    markRead(id,index,is_read){
     if(this.$refs.content[index].classList.contains('d-none')){
      this.$refs.content[index].classList.remove("d-none");
     }else{
      this.$refs.content[index].classList.add('d-none');
     }
     if(is_read==0){
        axios.post(route("markAsRead.notification",id))
        .then(response => {
          this.$store.dispatch('notification/notificationByUser');
        })
        // eslint-disable-next-line
        .catch(errors => {
            //Handle Errors
        })
     }
    }
      
    }
}
</script>

<style>

</style>