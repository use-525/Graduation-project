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
                    <form @submit.prevent="addNotifi" @keydown="form.onKeydown($event)" class="form-horizontal">
                        <div class="form-group row">
                            <label class="col-sm-2 col-form-label">Tiêu đề <span class="text-danger">*</span> :</label>
                            <div class="col-sm-10">
                                <input v-model="form.title" type="text" :class="{ 'is-invalid': form.errors.has('title') }" name="title" class="form-control" placeholder="Nhập tiêu đề">
                                <div class="text-danger" v-if="form.errors.has('title')" v-html="form.errors.get('title')"></div>
                            </div>
                        </div>
                         <div class="form-group row">
                            <label class="col-sm-2 col-form-label">Tài khoản <span class="text-danger">*</span> : </label>
                            <div class="col-sm-10">
                               <select  class="form-control select2" aria-label="Default select example"
                                name="user_id" v-model="form.user_id"
                                :class="{'is-invalid': form.errors.has('user_id'), }">
                                <option value="">Chọn tài khoản</option>
                                <option v-for="user in users"
                                  :key="user.id"
                                  :value="user.id">
                                  {{ user.name }}
                                </option>
                              </select>
                              <div class="text-danger"  v-if="form.errors.has('user_id')"
                                v-html="form.errors.get('user_id')"/>
                            </div>
                        </div>
                         <div class="form-group row">
                            <label class="col-sm-2 col-form-label">Nội dung <span class="text-danger">*</span> :</label>
                            <div class="col-sm-10">
                               <ckeditor v-model="form.content" :class="{ 'is-invalid': form.errors.has('content') }" name="content"></ckeditor>
                                <div class="text-danger" v-if="form.errors.has('content')" v-html="form.errors.get('content')" />
                            </div>
                        </div>
                        <div class="form-group row">
                            <div class="col-sm-10 ml-sm-auto">
                                <button class="btn btn-info" type="submit">Thêm mới</button>
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
export default {
   data:() => ({
    form: new Form({
      content:'',
      title: '',
      user_id: ''
    }),
    title: 'Tạo thông báo',
  }),
   components:{
      Footer
  },
  computed: {
    users() {
      return this.$store.state.user.all;
    },
  },
  created: function () {
    this.$store.dispatch("user/all");
  },
    methods: {
        async addNotifi () {
            if(Permissions.indexOf('create notifications') == -1){
            Swal.fire({
                icon: 'error',
                title: 'Oops...',
                text: 'Bạn không có quyền tạo!',
                })
            }else{
                await this.form.post(route('create.notification'))
                .then(response => {
                    if(response.data.status == 'success'){
                    this.$router.push({ name: 'admin.notifications' })
                        Swal.fire(
                            'Created',
                            'Tạo thông báo thành công!',
                            'success'
                        );
                    }
                }).catch(()=>{
                Swal.fire({
                        icon: 'error',
                        title: 'Oops...',
                        text: 'Đã có lỗi xảy ra!',
                        })
                });
            }
        },
    }
}
</script>

<style>

</style>