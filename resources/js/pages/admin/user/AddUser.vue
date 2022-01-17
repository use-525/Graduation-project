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
                  <div class="clf">
                    <form @submit.prevent="addUser" @keydown="form.onKeydown($event)" class="form-horizontal row">
                       <ul class="nav nav-tabs tabs-line-left col-2">
                          <li class="nav-item">
                              <a class="nav-link active" href="#tab-9-1" data-toggle="tab"><i class="fa fa-line-chart"></i> Tổng quan</a>
                          </li>
                          <li class="nav-item">
                              <a class="nav-link" href="#tab-9-2" data-toggle="tab"><i class="fa fa-heartbeat"></i> Quyền hạn</a>
                          </li>
                      </ul>
                      <div class="tab-content col-9">
                          <div class="tab-pane fade show active" id="tab-9-1">
                            <div class="form-group row">
                                <label for="" class="col-sm-2 col-form-label">Username <span class="text-danger">*</span> :</label>
                                <div class="col-sm-10">
                                    <input type="text" v-model="form.username" :class="{ 'is-invalid': form.errors.has('username') }"  class="form-control" placeholder="Enter username">
                                    <div class="text-danger" v-if="form.errors.has('username')" v-html="form.errors.get('username')" />
                                </div>
                            </div>
                            <div class="form-group row">
                                <label for="" class="col-sm-2 col-form-label">Họ tên <span class="text-danger">*</span> :</label>
                                <div class="col-sm-10">
                                    <input type="text" v-model="form.name" :class="{ 'is-invalid': form.errors.has('name') }"  class="form-control" placeholder="Họ tên">
                                    <div class="text-danger" v-if="form.errors.has('name')" v-html="form.errors.get('name')" />
                                </div>
                            </div>
                             <div class="form-group row">
                                <label for="" class="col-sm-2 col-form-label">Email <span class="text-danger">*</span> :</label>
                                <div class="col-sm-10">
                                    <input type="text" v-model="form.email" :class="{ 'is-invalid': form.errors.has('email') }"  class="form-control" placeholder="Enter email">
                                    <div class="text-danger" v-if="form.errors.has('email')" v-html="form.errors.get('email')" />
                                </div>
                            </div>
                             <div class="form-group row">
                                <label for="" class="col-sm-2 col-form-label">Mật khẩu <span class="text-danger">*</span> :</label>
                                <div class="col-sm-10">
                                    <input type="password" v-model="form.password" :class="{ 'is-invalid': form.errors.has('password') }"  class="form-control" placeholder="Enter password">
                                    <div class="text-danger" v-if="form.errors.has('password')" v-html="form.errors.get('password')" />
                                </div>
                            </div>
                             <div class="form-group row">
                                <label for="" class="col-sm-2 col-form-label">Ảnh:</label>
                                <div class="col-sm-10">
                                   <input type="file" @change="upload($event)" :class="{ 'is-invalid': form.errors.has('image') }" class="form-control" name="image">
                                   <div class="text-danger" v-if="form.errors.has('image')" v-html="form.errors.get('image')" />
                                    <img id="previewImg" alt="" width="200" />
                                </div>
                            </div>
                             <div class="form-group row">
                                <label for="" class="col-sm-2 col-form-label">Vai trò <span class="text-danger">*</span> :</label>
                                <div class="col-sm-10">
                                   <select class="form-control select2" v-model="form.role_id" :class="{ 'is-invalid': form.errors.has('role_id') }" name="role_id" style="width: 100%;">
                                      <option value="">Role</option>
                                      <option v-for="role in roles" :key="role.id" :value="role.id">{{role.name}}</option>
                                    </select>
                                    <div class="text-danger" v-if="form.errors.has('role_id')" v-html="form.errors.get('role_id')" />
                                </div>
                            </div>
                             <div class="form-group row">
                                <label for="" class="col-sm-2 col-form-label">Địa chỉ:</label>
                                <div class="col-sm-10">
                                   <input type="text" class="form-control" v-model="form.address" :class="{ 'is-invalid': form.errors.has('address') }" placeholder="Nhập địa chỉ">
                                   <div class="text-danger" v-if="form.errors.has('address')" v-html="form.errors.get('address')" />
                                </div>
                            </div>
                             <div class="form-group row">
                                <label for="" class="col-sm-2 col-form-label">Số điện thoại <span class="text-danger">*</span> :</label>
                                <div class="col-sm-10">
                                   <input type="text" class="form-control" v-model="form.phone" :class="{ 'is-invalid': form.errors.has('phone') }" placeholder="Nhập số điện thoại">
                                   <div class="text-danger" v-if="form.errors.has('phone')" v-html="form.errors.get('phone')" />
                                </div>
                            </div>
                            <div class="form-group row">
                                <label for="" class="col-sm-2 col-form-label">Gender:</label>
                                <div class="col-md-10">
                                  <label class="ui-radio ui-radio-primary mr-3" for="male">
                                      <input type="radio" name="gender" :value="1" id="male" v-model="form.gender">
                                      <span class="input-span"></span>Nam</label>
                                  <label class="ui-radio ui-radio-primary" for="female">
                                      <input type="radio" name="gender" :value="0" id="female" v-model="form.gender">
                                      <span class="input-span"></span>Nữ</label>
                                  <div class="text-danger" v-if="form.errors.has('gender')" v-html="form.errors.get('gender')" />
                                </div>
                              </div>
                              <div class="form-group row">
                                <label class="col-sm-2 col-form-label">Active</label>
                                <div class="col-md-10">
                                    <label class="ui-checkbox ui-checkbox-primary" for="is_active">
                                     <input type="checkbox" v-model="form.is_active" class="form-check-input" id="is_active">
                                    <span class="input-span"></span><strong>Active</strong></label>
                                </div>
                              </div>
                            <div class="form-group row">
                              <div class="col-sm-10 ml-sm-auto">
                                  <button class="btn btn-info" type="submit">Submit</button>
                              </div>
                            </div>
                          </div>
                          <div class="tab-pane" id="tab-9-2">
                             <div class="form-group">
                                <label class="ui-checkbox ui-checkbox-primary" for="select_all">
                                     <input type="checkbox" v-model="selectAll" class="form-check-input" id="select_all">
                                    <span class="input-span"></span><strong>Select all</strong></label>
                             </div>
                            <div class="form-group" v-for="permission in permissions" :key="permission.id">
                                <label class="ui-checkbox ui-checkbox-primary" :for="'per_'+permission.id">
                                    <input class="form-check-input" type="checkbox" :id="'per_'+permission.id" :value="permission.id" v-model="form.permission_id">
                                    <span class="input-span"></span>{{permission.name}}</label>
                             </div>
                           <div class="text-danger" v-if="form.errors.has('permission_id')" v-html="form.errors.get('permission_id')" />
                             <v-button :loading="form.busy">Thêm mới</v-button>
                          </div>
                      </div> 
                    </form>
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
export default {
   data:() => ({
    form: new Form({
      username: '',
      name: '',
      email: '',
      password: '',
      image: '',
      role_id: '',
      address: '',
      phone: '',
      gender: '',
      is_active: '',
      permission_id: []
    }),
    title: 'Tạo tài khoản',
  }),
    components:{
      Footer
    },
     computed: {
          roles () {
              return this.$store.state.role.all;
          },
          permissions () {
            return this.$store.state.permission.all;
        },
         selectAll: {
             get: function () {
                return this.permissions ? this.form.permission_id.length == this.permissions.length : false;
            },
            set: function (value) {
                var permission_id = [];

                if (value) {
                    this.permissions.forEach(function (permission) {
                        permission_id.push(permission.id);
                    });
                }

                this.form.permission_id = permission_id;
            }
        },
      },
      created: function () {
          this.$store.dispatch('role/all');
           this.$store.dispatch('permission/all');
      },
    methods: {
        upload(event){
         var file = this.form.image = event.target.files[0];
            if(file){
                var reader = new FileReader();
                reader.onload = function(){
                    $('#previewImg').attr("src",reader.result);
                }
                reader.readAsDataURL(file);
            }
        },
        async addUser () {
       if(Permissions.indexOf('create users') == -1){
            Swal.fire({
              icon: 'error',
              title: 'Oops...',
              text: 'Bạn không có quyền thêm tài khoản!',
              })
        }else{
            await this.form.post(route('create.user'))
            .then(response => {
                if(response.data.status == 'success'){
                this.$router.push({ name: 'users' })
                    Swal.fire(
                        'Đã thêm',
                        'Tài khoản đã tạo thành công!',
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