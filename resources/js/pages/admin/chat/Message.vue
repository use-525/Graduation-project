<template>
    <div id="msg_card_body">
        <div v-for="(message, index) in allMessages" :key="index">
             <div v-if="user.id==message.user_id" class="d-flex justify-content-end mb-5">
                <div class="msg_cotainer_send">
                    <span v-if="message.message">{{message.message}}</span>
                    
                    <img v-if="message.image"  :src="'/'+message.image" alt="" width="500">
                    <span class="msg_time_send">{{message.time}}</span>
                </div>
                <div class="img_cont_msg">
                    <img v-if="user.image" :src="'/'+user.image" class="rounded-circle user_img_msg">
                </div>
            </div>
             <div v-else class="d-flex justify-content-start mb-5">
                <div class="img_cont_msg">
                    <img v-if="message.user.image" :src="'/'+message.user.image" class="rounded-circle user_img_msg">
                </div>
                <div class="msg_cotainer">
                    <span v-if="message.message">{{message.message}}</span>
                     <img v-if="message.image"  :src="'/'+message.image" alt="" width="500">
                    <span class="msg_time">{{message.time}}</span>
                </div>
            </div>
        </div>
       
    </div>
</template>
<script>
 export default {
    props:['user','allMessages'],
}
</script>