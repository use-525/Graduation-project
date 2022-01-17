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
                    <form @submit.prevent="addPermission" @keydown="form.onKeydown($event)" class="form-horizontal">
                        <div class="form-group row">
                            <label class="col-sm-2 col-form-label">Name</label>
                            <div class="col-sm-10">
                                <input v-model="form.name" type="text" :class="{ 'is-invalid': form.errors.has('name') }" name="name" class="form-control" placeholder="Enter name">
                                <div class="text-danger" v-if="form.errors.has('name')" v-html="form.errors.get('name')"></div>
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
import Footer from '../../../components/AdminFooter.vue';
export default {
   data:() => ({
    form: new Form({
      name: '',
    }),
    title: 'Add permission',
  }),
   components:{
      Footer
  },
    methods: {
        async addPermission () {
            if(Permissions.indexOf('create permissions') == -1){
            Swal.fire({
                icon: 'error',
                title: 'Oops...',
                text: 'Bạn không có quyền tạo!',
                })
            }else{
                await this.form.post(route('create.permission'))
                .then(response => {
                    if(response.data.status == 'success'){
                    this.$router.push({ name: 'permissions' })
                        Swal.fire(
                            'Created',
                            'Thêm quyền thành công!',
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