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
                    <form @submit.prevent="updateOrder" @keydown="form.onKeydown($event)" class="form-horizontal">
                        <div class="row">
                            <div class="col-sm-2">
                                <p>Mã hoá đơn</p>
                            </div>
                            <div class="col-sm-10">
                                <p>{{order.order_nr}}</p>
                            </div>
                        </div>
                        <div class="row" v-if="order.upgrade">
                            <div class="col-sm-2">
                                <p>Gói sử dụng</p>
                            </div>
                            <div class="col-sm-10">
                                <p>{{order.upgrade.name}}</p>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-sm-2">
                                <p>Số tiền</p>
                            </div>
                            <div class="col-sm-10">
                                <p>{{order.amount}} VNĐ</p>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-sm-2">
                                <p>Ngày hết hạn</p>
                            </div>
                            <div class="col-sm-10">
                                <p>{{order.expiration}}</p>
                            </div>
                        </div>
                        <div class="row" v-if="order.user">
                            <div class="col-sm-2">
                                <p>Tên người dùng</p>
                            </div>
                            <div class="col-sm-10">
                                <p>{{order.user.name}}</p>
                            </div>
                        </div>
                        <div class="row" v-if="order.user">
                            <div class="col-sm-2">
                                <p>Địa chỉ email</p>
                            </div>
                            <div class="col-sm-10">
                                <p>{{order.user.email}}</p>
                            </div>
                        </div>
                        <div class="row" v-if="order.user">
                            <div class="col-sm-2">
                                <p>Số điện thoại</p>
                            </div>
                            <div class="col-sm-10">
                                <p>{{order.user.phone}}</p>
                            </div>
                        </div>
                        
                        <div class="form-group row">
                            <label class="col-sm-2 col-form-label">Trạng thái</label>
                            <div class="col-sm-10">
                                <select v-model="order.status" :class="{ 'is-invalid': form.errors.has('status') }" type="text" name="status" class="form-control" placeholder="Enter status">
                                    <option value="0">Chờ Thanh Toán</option>
                                    <option value="1">Thành Công</option>
                                    <option value="2">Lỗi</option>
                                </select>
                                <div class="text-danger" v-if="form.errors.has('status')" v-html="form.errors.get('status')">
                                </div>
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
import { mapGetters } from 'vuex'
import Footer from '../../../components/AdminFooter.vue';

export default {
   data:() => ({
    form: new Form({
      status: '',
    }),
    title: 'Chi tiết hoá đơn'
  }),
  components:{
      Footer
  },
    computed: mapGetters({
      order: 'order/order'
  }),
      created () {
        this.$store.dispatch('order/fetchOne',this.$route.params.id);
       
      },
    methods: {
        async updateOrder () {
            if(Permissions.indexOf('edit orders') == -1){
                Swal.fire({
                icon: 'error',
                title: 'Oops...',
                text: 'Bạn không có quyền sửa!',
                })
            }else{
                this.form.status = this.order.status
                await this.form.post(route('update.order',this.$route.params.id))
                .then(response => {
                    if(response.data.status == 'success'){
                        this.$router.push({ name: 'admin.orders' })
                        Swal.fire(
                            'Update',
                            'Hoá đơn cập nhật thành công',
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