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
                    <form @submit.prevent="updatePermission" @keydown="form.onKeydown($event)" class="form-horizontal">
                        <div class="form-group row">
                            <label class="col-sm-2 col-form-label">Name</label>
                            <div class="col-sm-10">
                                <input v-model="permission.name" :class="{ 'is-invalid': form.errors.has('name') }" type="text" name="name" class="form-control" placeholder="Enter name">
                                <div class="text-danger" v-if="form.errors.has('name')" v-html="form.errors.get('name')">
                                </div>
                            </div>
                        </div>
                        <div class="form-group row">
                            <div class="col-sm-10 ml-sm-auto">
                                <button class="btn btn-info" type="submit">Submit</button>
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
import { mapGetters } from 'vuex'
import Footer from '../../../components/AdminFooter.vue';

export default {
   data:() => ({
    form: new Form({
      name: '',
      guard_name: ''
    }),
    title: 'Edit permission'
  }),
  components:{
      Footer
  },
    computed: mapGetters({
      permission: 'permission/permission'
  }),
      created () {
        this.$store.dispatch('permission/fetchOne',this.$route.params.id);
       
      },
    methods: {
        async updatePermission () {
            if(Permissions.indexOf('edit permissions') == -1){
                        Swal.fire({
                        icon: 'error',
                        title: 'Oops...',
                        text: 'Bạn không có quyền sửa!',
                        })
            }else{
                this.form.name = this.permission.name
                this.form.guard_name = this.permission.guard_name
                await this.form.post(route('update.permission',this.$route.params.id))
                .then(response => {
                    if(response.data.status == 'success'){
                        this.$router.push({ name: 'permissions' })
                        Swal.fire(
                            'Update',
                            'Cập nhật quyền thành công',
                            'success'
                        );
                    }
                }).catch(()=>{
                Swal.fire({
                        icon: 'error',
                        title: 'Oops...',
                        text: 'Đã  xảy ra lỗi!',
                        })
                });
            }                   
        },
    }
}
</script>

<style>

</style>