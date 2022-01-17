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
                    <form @submit.prevent="updateUpgrade" @keydown="form.onKeydown($event)" class="form-horizontal">
                        <div class="form-group row">
                            <label class="col-sm-2 col-form-label">Tên <span class="text-danger">*</span> : </label>
                            <div class="col-sm-10">
                                <input v-model="upgrade.name" :class="{ 'is-invalid': form.errors.has('name') }" type="text" name="name" class="form-control" placeholder="Nhập tên">
                                <div class="text-danger" v-if="form.errors.has('name')" v-html="form.errors.get('name')">
                                </div>
                            </div>
                        </div>
                         <div class="form-group row">
                            <label class="col-sm-2 col-form-label">Giá tiền <span class="text-danger">*</span> : </label>
                            <div class="col-sm-10">
                                <input v-model="upgrade.price" type="text" :class="{ 'is-invalid': form.errors.has('price') }" name="price" class="form-control" placeholder="Nhập giá">
                                <div class="text-danger" v-if="form.errors.has('price')" v-html="form.errors.get('price')"></div>
                            </div>
                        </div>
                        <div class="form-group row">
                            <label class="col-sm-2 col-form-label">Thời hạn (tháng) <span class="text-danger">*</span> : </label>
                            <div class="col-sm-10">
                                <input v-model="upgrade.period" type="number" step="1" min="1" :class="{ 'is-invalid': form.errors.has('period') }" name="period" class="form-control" placeholder="Nhập thời hạn">
                                <div class="text-danger" v-if="form.errors.has('period')" v-html="form.errors.get('period')"></div>
                            </div>
                        </div>
                         <div class="form-group row">
                            <label class="col-sm-2 col-form-label">Mô tả <span class="text-danger">*</span> : </label>
                            <div class="col-sm-10">
                               <ckeditor v-model="upgrade.description" :class="{ 'is-invalid': form.errors.has('description') }" name="description"></ckeditor>
                                <div class="text-danger" v-if="form.errors.has('description')" v-html="form.errors.get('description')" />
                            </div>
                        </div>
                        <div class="form-group row">
                            <div class="col-sm-10 ml-sm-auto">
                                <button class="btn btn-info" type="submit">Cập nhật</button>
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
      description:'',
      price: '',
      period: ''
    }),
    title: 'Chi tiết gói'
  }),
  components:{
      Footer
  },
    computed: mapGetters({
      upgrade: 'upgrade/upgrade'
  }),
      created () {
        this.$store.dispatch('upgrade/fetchOne',this.$route.params.id);
       
      },
    methods: {
        async updateUpgrade () {
            if(Permissions.indexOf('edit upgrades') == -1){
                Swal.fire({
                icon: 'error',
                title: 'Oops...',
                text: 'Bạn không có quyền sửa!',
                })
            }else{
                this.form.name = this.upgrade.name
                this.form.price = this.upgrade.price
                this.form.description = this.upgrade.description
                this.form.period = this.upgrade.period
                await this.form.post(route('update.upgrade',this.$route.params.id))
                .then(response => {
                    if(response.data.status == 'success'){
                        this.$router.push({ name: 'admin.upgrades' })
                        Swal.fire(
                            'Update',
                            'Cập nhật gói thành công!',
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
            }                   
        },
    }
}
</script>

<style>

</style>