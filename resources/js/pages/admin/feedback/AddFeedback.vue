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
                    <!-- <div class="ibox-tools">
                        <a class="ibox-collapse"><i class="fa fa-minus"></i></a>
                    </div> -->
                </div>
                <div class="ibox-body">
                    <form @submit.prevent="addFeedback" @keydown="form.onKeydown($event)" class="form-horizontal">
                       <div class="form-group row">
                            <label class="col-sm-2 col-form-label">Nội dung<span class="text-danger">*</span> : </label>
                            <div class="col-sm-10">
                               <ckeditor v-model="form.feedback_content" :class="{ 'is-invalid': form.errors.has('feedback_content') }" name="feedback_content"></ckeditor>
                                <!-- <input v-model="form.name" type="text" :class="{ 'is-invalid': form.errors.has('name') }" name="name" class="form-control" id="exampleInputName" placeholder="Enter name"> -->
                                <div class="text-danger" v-if="form.errors.has('feedback_content')" v-html="form.errors.get('feedback_content')" />
                            </div>
                        </div>
                        <div class="form-group row">
                            <div class="col-sm-10 ml-sm-auto">
                                <button class="btn btn-info" type="submit">Gửi</button>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
            
        </div>
        <!-- END PAGE CONTENT-->
        <Footer></Footer>
    </div>
</template>

<script>
import Footer from '../../../components/AdminFooter.vue';
import Cookies from 'js-cookie'

export default {
   data:() => ({
    form: new Form({
      feedback_content: '',
    }),
    title: 'Trả lời bình luận',
  }),
   components:{
      Footer
  },
    methods: {
        async addFeedback () {
        await this.form.post(route('create.feedback',[this.$route.params.parent_id,this.$route.params.solution_id]),{headers : {'Accept':'application/json',
      'Authorization': 'Bearer '+ Cookies.get('token')}})
        .then(response => {
            if(response.data.status == 'success'){
            this.$router.push({ name: 'feedbacks' })
                Swal.fire(
                    'Thành công',
                    'Gửi bình luận thành công.',
                    'success'
                );
            }
        }).catch(()=>{
        Swal.fire({
                icon: 'error',
                title: 'Oops...',
                text: 'Đã xảy ra lỗi!',
                })
        });
        
        },
    }
}
</script>

<style>

</style>