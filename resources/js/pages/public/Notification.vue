<template>
 <section class="content mb-5 mt-5">
    <div class="container">
      <div class="row">
        <div class="col-12">
          <h2>Thông báo</h2>
            <div class="list-group list-group-divider">
                   <div>
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
    </div>
  </section>
</template>

<script>
import { mapGetters } from 'vuex'

export default {
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
};
</script>

<style lang="scss">
@import "../../../sass/solution-detail.scss";

</style>
