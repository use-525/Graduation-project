<template>
    <div class="content-wrapper">
        <!-- START PAGE CONTENT-->
        <div class="page-heading">
            <breadcrumb :title='title'></breadcrumb>
        </div>
        <div class="page-content fade-in-up">
             <div class="row">
                    <div class="col-lg-3 col-md-4 pr-0 border-right">
                        <div class="ibox" style="height:700px">
                            <div class="ibox-body">
                                <form class="mail-search mb-3" action="javascript:;">
                                    <div class="input-group">
                                        <input v-model="search" @keyup="searchRooms" class="form-control" type="text" placeholder="Search here...">
                                    </div>
                                </form>
                                <ul class="nav nav-tabs tabs-line">
                                    <li class="nav-item">
                                        <router-link :to="{name:'admin.private-chat'}" class="nav-link"><i class="ti-user"></i> Thành viên</router-link>
                                    </li>
                                    <li class="nav-item">
                                        <router-link :to="{name:'admin.chat'}" class="nav-link active"><i class="fa fa-users"></i> Nhóm</router-link>
                                    </li>
                                </ul>
                                <div class="tab-content">
                                    <div class="tab-pane fade show active contacts_body">
                                        <ul class="contacts">
                                             <li v-for="room in chatRooms"
                                                :key="room.id"
                                                @click="currentRoom=room">
                                                <div :class="(room.id==currentRoom.id)?'d-flex bd-highlight active':'d-flex bd-highlight'">
                                                    <div class="img_cont">
                                                        <img :src="'/'+room.image" class="rounded-circle user_img">
                                                    </div>
                                                    <div class="user_info">
                                                        <span>{{room.name}}</span>
                                                        <!-- <p>Taherah left 7 mins ago</p> -->
                                                    </div>
                                                </div>
                                            </li>
                                        </ul>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-9 col-md-8 pl-0">
                        <div class="ibox" style="height:700px">
                            <div class="ibox-body">
                                <div class="nav-tabs">
                                    <div class="d-flex bd-highlight" v-if="currentRoom">
                                        <div class="img_cont">
                                            <img  :src="'/'+currentRoom.image" class="rounded-circle user_img">
                                            <!-- <span class="online_icon"></span> -->
                                        </div>
                                        <div class="user_info">
                                            <span>{{currentRoom.name}}</span>
                                        </div>
                                    </div>
                                </div>
                                <!-- message list-->
                                <message-list :user="user" :all-messages="allMessages"></message-list>
                                <div class="floating-div">
                                    <picker v-if="emoStatus" set="emojione" @select="onInput" title="Pick your emoji…" />
                                </div>
                                 <div class="type_msg row">
                                     <div class="col-1 mt-1">
                                         <button type="button" @click="toggleEmo" class="btn btn-warning btn-floating-icon">
                                         <i class="ti-face-smile"></i>
                                     </button>
                                     </div>
                                     <file-upload
                                    :custom-action="upLoad"
                                    ref='upload'
                                    v-model="files"
                                    @input-file="$refs.upload.active = true"
                                    :headers="{'X-CSRF-TOKEN': token}"
                                    >
                                       <div class="mt-3 "> <i class="ti-clip" style="font-size: 20px;"></i></div>
                                    </file-upload>
                                    <div class="input_msg_write col-10">
                                    <input type="text" v-model="message" @keyup.enter="sendMessage" class="write_msg" placeholder="Type a message..." />
                                    <button class="msg_send_btn" @click="sendMessage" type="button"><i class="fa fa-paper-plane-o" aria-hidden="true"></i></button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
        </div>
        <!-- END PAGE CONTENT-->
        <Footer></Footer>
         <audio id="ChatAudio">
            <source src="/files/chat.mp3">
        </audio>
    </div>
</template>

<script>
import Footer from '../../../components/AdminFooter.vue';
import MessageList from './Message.vue'
import { Picker } from 'emoji-mart-vue'
import Cookies from 'js-cookie';

export default {
   data:() => ({
        title: 'Trao đổi',
        search: '',
        // user:null,
        message:null,
        emoStatus:false,
        myText:null,
        allMessages:[],
        chatRooms: [],
        currentRoom:{},
        files:[],
        token:document.head.querySelector('meta[name="csrf-token"]').content
  }),
   components:{
      Footer,
      MessageList,
      Picker
  },
  computed:{
      user(){
          return this.$store.state.auth.user;
      },
    },
  created(){
      this.$store.dispatch('auth/fetchUser');
      this.getRooms();
    },
     watch:{
      currentRoom(val){
        this.fetchMessages();
      }
      
    },
    methods: {
         sendMessage(){
        //check if there message
        if(!this.message){
          return;
        }
          axios.post(route("newMessage",this.currentRoom.id), { message: this.message},{headers : {'Accept':'application/json','X-CSRF-TOKEN': this.token,
        'Authorization': 'Bearer '+ Cookies.get('token')}}).then(response => {
                    this.message=null;
                    this.emoStatus=false;
                    this.allMessages.push(response.data.data)
                    this.scrollToEnd();
          });
        },
        upLoad(file){
          
        let data = new FormData();
        data.append('file',file.file); 
          axios.post(route("newMessage",this.currentRoom.id), data,{headers : {'Accept':'application/json','Content-Type' : 'image/png',
        'Authorization': 'Bearer '+ Cookies.get('token')}}).then(response => {
                    this.files=[];
                    this.allMessages.push(response.data.data)
                    this.scrollToEnd();
          });
      },
        getRooms() {
            axios.get(route('rooms'),{headers : {'Accept':'application/json',
                'Authorization': 'Bearer '+ Cookies.get('token')}})
                .then((response) => {
                this.chatRooms = response.data.data;
                this.setRoom(response.data.data[0]);
            });
            
        },
        searchRooms(){
            axios.get(route('search.room',this.search)).then(response => {
                this.chatRooms = response.data.data;
            }); 
        },
        setRoom(room) {
            this.currentRoom = room;
            this.connect();
        },
        connect(){
                Echo.private("chat." + this.currentRoom.id)
            .listen('NewChatMessage',(e)=>{
                this.allMessages.push(e.message)
                document.getElementById('ChatAudio').play();
                this.scrollToEnd();
            });
        },
        fetchMessages() {
            // console.log(this.currentRoom)
            axios.get(route("messages", this.currentRoom.id),{headers : {'Accept':'application/json',
            'Authorization': 'Bearer '+ Cookies.get('token')}})
            .then((response) => {
            this.allMessages = response.data.data;
            this.scrollToEnd();
            }) 
        },
        scrollToEnd: function() {
            setTimeout(function () {
                document.getElementById('msg_card_body').scrollTo(0,99999);
            }, 0);
        },
        onInput(e){
        if(!e){
          return false;
        }
        if(!this.message){
          this.message=e.native;
        }else{
          this.message=this.message + e.native;
        }
      },
       toggleEmo(){
            this.emoStatus= !this.emoStatus;
      }
    }
}
</script>

<style>
    .contacts_body{
        padding:  0.75rem 0 !important;
        overflow-y: auto;
        white-space: nowrap;
        height: 555px;
    }
    #msg_card_body{
        overflow-y: auto;
        height: 540px;
    }
    .contacts{
        list-style: none;
        padding: 0;
    }
    .contacts li{
        width: 100% !important;
        padding: 5px 10px;
        margin-bottom: 15px !important;
    }
    .user_img{
        height: 50px;
        width: 50px;
        border:1.5px solid #f5f6fa;
    }
    .user_img_msg{
        height: 40px;
        width: 40px;
        border:1.5px solid #f5f6fa;
    }
	.img_cont{
        position: relative;
        height: 50px;
        width: 50px;
	}
	.img_cont_msg{
			height: 40px;
			width: 40px;
	}
	.online_icon{
		position: absolute;
		height: 10px;
		width:10px;
		background-color: #4cd137;
		border-radius: 50%;
		bottom: 0.2em;
		right: 0.2em;
		border:1.5px solid white;
	}
	.offline{
		background-color: #c23616 !important;
	}
	.user_info{
		margin-top: auto;
		margin-bottom: auto;
		margin-left: 15px;
	}
	.user_info span{
		font-size: 14px;
		color: black;
	}
	.user_info p{
	font-size: 10px;
	color: rgba(24, 23, 23, 0.6);
	}
    	.msg_cotainer{
		margin-top: auto;
		margin-bottom: auto;
		margin-left: 10px;
		border-radius: 25px;
		background-color: #82ccdd;
		padding: 10px;
		position: relative;
	}
	.msg_cotainer_send{
		margin-top: auto;
		margin-bottom: auto;
		margin-right: 10px;
		border-radius: 25px;
		background-color: #78e08f;
		padding: 10px;
		position: relative;
	}
	.msg_time{
		position: absolute;
		left: 0;
		bottom: -30px;
		color: rgba(22, 22, 22, 0.5);
		font-size: 10px;
	}
	.msg_time_send{
		position: absolute;
		right:0;
		bottom: -30px;
		color: rgba(12, 12, 12, 0.5);
		font-size: 10px;
	}
	.msg_head{
		position: relative;
	}
    .input_msg_write input {
        background: rgba(0, 0, 0, 0) none repeat scroll 0 0;
        border: medium none;
        color: #4c4c4c;
        font-size: 15px;
        min-height: 48px;
        width: 100%;
    }

    .type_msg {
        border-top: 1px solid #c4c4c4;
        border-bottom: 1px solid #c4c4c4;
        position: relative;
    }
    .msg_send_btn {
        background: #05728f none repeat scroll 0 0;
        border: medium none;
        border-radius: 50%;
        color: #fff;
        cursor: pointer;
        font-size: 17px;
        height: 33px;
        position: absolute;
        right: 0;
        top: 11px;
        width: 33px;
    }
    .floating-div{
        position: fixed;
        bottom: 170px;
    }
    .btn-floating-icon{
        border-radius: 50%;
        width: 40px;
        height: 40px;
    }
    .btn-floating-icon i{
        font-size: 17px;
    }
     ul.contacts li .bd-highlight.active{
        background: #f1f1f1;
    }
</style>