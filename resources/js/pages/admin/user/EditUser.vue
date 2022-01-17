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
                    <form @submit.prevent="updateUser"  @keydown="form.onKeydown($event)" class="form-horizontal row">
                       <ul class="nav nav-tabs tabs-line-left col-2">
                          <li class="nav-item">
                              <a class="nav-link active" href="#tab-9-1" data-toggle="tab"><i class="fa fa-line-chart"></i> Tổng quan</a>
                          </li>
                          <li class="nav-item">
                              <a class="nav-link" href="#tab-9-2" data-toggle="tab"><i class="fa fa-heartbeat"></i> Quyền hạn</a>
                          </li>
                          <li class="nav-item">
                              <a class="nav-link" href="#tab-9-3" data-toggle="tab"><i class="ti-write"></i> Mật khẩu</a>
                          </li>
                      </ul>
                      <div class="tab-content col-9"  v-if="data.user">
                          <div class="tab-pane fade show active" id="tab-9-1">
                            <div class="form-group row">
                                <label for="" class="col-sm-2 col-form-label">Username <span class="text-danger">*</span> :</label>
                                <div class="col-sm-10">
                                    <input type="text" v-model="data.user.username" :class="{ 'is-invalid': form.errors.has('username') }" class="form-control" name="username" placeholder="Tên tài khoản">
                                    <div class="text-danger" v-if="form.errors.has('username')" v-html="form.errors.get('username')" />
                                </div>
                            </div>
                            <div class="form-group row">
                                <label for="" class="col-sm-2 col-form-label">Họ tên <span class="text-danger">*</span> :</label>
                                <div class="col-sm-10">
                                    <input type="text" v-model="data.user.name" :class="{ 'is-invalid': form.errors.has('name') }" class="form-control" placeholder="Nhập họ tên">
                                    <div class="text-danger" v-if="form.errors.has('name')" v-html="form.errors.get('name')" />
                                </div>
                            </div>
                             <div class="form-group row">
                                <label for="" class="col-sm-2 col-form-label">Email <span class="text-danger">*</span> :</label>
                                <div class="col-sm-10">
                                    <input type="email" v-model="data.user.email" :class="{ 'is-invalid': form.errors.has('email') }" class="form-control" name="email" placeholder="Nhập email">
                                    <div class="text-danger" v-if="form.errors.has('email')" v-html="form.errors.get('email')" />
                                </div>
                            </div>
                             <div class="form-group row">
                                <label for="" class="col-sm-2 col-form-label">Ảnh:</label>
                                <div class="col-sm-10">
                                  <input type="file" @change="upload($event)" :class="{ 'is-invalid': form.errors.has('image') }" class="form-control" name="image">
                                  <div class="text-danger" v-if="form.errors.has('image')" v-html="form.errors.get('image')" />
                                  <img id="previewImg" v-if="data.user.image" :src="'/'+data.user.image" alt="" width="200">
                                  <img id="previewImg" v-else :src="data.user.photo_url" alt="" width="200">
                                </div>
                            </div>
                             <div class="form-group row">
                                <label for="" class="col-sm-2 col-form-label">Vai trò <span class="text-danger">*</span> :</label>
                                <div class="col-sm-10">
                                  <select class="form-control select2" v-model="data.user.role.role_id" :class="{ 'is-invalid': form.errors.has('role_id') }" name="role_id" style="width: 100%;">
                                    <option v-for="role in data.roles" :key="role.id" :value="role.id" :selected="role.id == data.user.role.role_id">{{role.name}}</option>
                                  </select>
                                  <div class="text-danger" v-if="form.errors.has('role_id')" v-html="form.errors.get('role_id')" />
                                </div>
                            </div>
                             <div class="form-group row">
                                <label for="" class="col-sm-2 col-form-label">Địa chỉ:</label>
                                <div class="col-sm-10">
                                   <input type="text" class="form-control" v-model="data.user.address" :class="{ 'is-invalid': form.errors.has('address') }" placeholder="Nhập địa chỉ">
                                   <div class="text-danger" v-if="form.errors.has('address')" v-html="form.errors.get('address')" />
                                </div>
                            </div>
                             <div class="form-group row">
                                <label for="" class="col-sm-2 col-form-label">Số điện thoại <span class="text-danger">*</span> :</label>
                                <div class="col-sm-10">
                                  <input type="text" class="form-control" :class="{ 'is-invalid': form.errors.has('phone') }" v-model="data.user.phone" placeholder="Nhập số điện thoại">
                                  <div class="text-danger" v-if="form.errors.has('phone')" v-html="form.errors.get('phone')" />
                                </div>
                            </div>
                            <div class="form-group row">
                                <label for="" class="col-sm-2 col-form-label">Giới tính:</label>
                                <div class="col-md-10">
                                  <label class="ui-radio ui-radio-primary mr-3" for="male">
                                      <input type="radio" name="gender" :value="1" id="male" v-model="data.user.gender">
                                      <span class="input-span"></span>Nam</label>
                                  <label class="ui-radio ui-radio-primary" for="female">
                                      <input type="radio" name="gender" :value="0" id="female" v-model="data.user.gender">
                                      <span class="input-span"></span>Nữ</label>
                                  <div class="text-danger" v-if="form.errors.has('gender')" v-html="form.errors.get('gender')" />
                                </div>
                              </div>
                              <div class="form-group row">
                                <label class="col-sm-2 col-form-label">Active</label>
                                <div class="col-md-10">
                                    <label class="ui-checkbox ui-checkbox-primary" for="is_active">
                                     <input type="checkbox" v-model="data.user.is_active" class="form-check-input" id="is_active">
                                    <span class="input-span"></span><strong>Active</strong></label>
                                </div>
                              </div>
                            <div class="form-group row">
                              <div class="col-sm-10 ml-sm-auto">
                                  <button class="btn btn-info" type="submit">Cập nhật</button>
                              </div>
                            </div>
                          </div>
                          <div class="tab-pane" id="tab-9-2">
                            <input type="hidden" v-model="permission_id">
                            <div class="form-group" v-for="permission in data.permissions" :key="permission.id">
                                <label class="ui-checkbox ui-checkbox-primary" :for="'per_'+permission.id">
                                    <input class="form-check-input" type="checkbox" :id="'per_'+permission.id" :value="permission.id" v-model="form.permission_id">
                                    <span class="input-span"></span>{{permission.name}}</label>
                             </div>
                           <div class="text-danger" v-if="form.errors.has('permission_id')" v-html="form.errors.get('permission_id')" />
                             <v-button :loading="form.busy">Submit</v-button>
                          </div>
                          <div class="tab-pane" id="tab-9-3">
                            <form @submit.prevent="updatePassword"  @keydown="form.onKeydown($event)" class="form-horizontal">
                              <div class="form-group row">
                                <label for="" class="col-sm-2 col-form-label">Mật khẩu hiện tại <span class="text-danger">*</span></label>
                                <div class="col-sm-10">
                                  <input type="password" v-model="formPass.password" :class="{ 'is-invalid': formPass.errors.has('password') }" class="form-control" name="username" placeholder="Nhập mật khẩu">
                                  <div class="text-danger" v-if="formPass.errors.has('password')" v-html="formPass.errors.get('password')" />
                                </div>
                              </div>
                              <div class="form-group row">
                                <label for="" class="col-sm-2 col-form-label">Mật khẩu mới <span class="text-danger">*</span> :</label>
                                <div class="col-sm-10">
                                  <input type="password" v-model="formPass.new_password" :class="{ 'is-invalid': formPass.errors.has('new_password') }" class="form-control" name="username" placeholder="Nhập mật khẩu mới">
                                  <div class="text-danger" v-if="formPass.errors.has('new_password')" v-html="formPass.errors.get('new_password')" />
                                </div>
                              </div>
                              <div class="form-group row">
                                <label for="" class="col-sm-2 col-form-label">Xác nhận mật khẩu mới <span class="text-danger">*</span> :</label>
                                <div class="col-sm-10">
                                  <input type="password" v-model="formPass.new_confirm_password" :class="{ 'is-invalid': formPass.errors.has('new_confirm_password') }" class="form-control" name="username" placeholder="Xác nhận mật khẩu">
                                  <div class="text-danger" v-if="formPass.errors.has('new_confirm_password')" v-html="formPass.errors.get('new_confirm_password')" />
                                </div>
                              </div>
                             <div class="form-group row">
                              <div class="col-sm-10 ml-sm-auto">
                                  <button class="btn btn-info" type="submit">Đổi mật khẩu</button>
                              </div>
                            </div>
                            </form>
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
      image: '',
      role_id: '',
      address: '',
      password:'',
      phone: '',
      gender: '',
      is_active: '',
      permission_id: []
    }),
    formPass: new Form({
      password: '',
      new_password: '',
      new_confirm_password: ''
    }),
    title: 'Cập nhật người dùng',
  }),
  components:{
    Footer
  },
   computed: {
      data () {
          return this.$store.state.user.user;
      },
      permission_id (){
        var permission_id = [];
          this.data.user.has_permission.forEach(function (permission) {
              permission_id.push(permission.permission_id);
          });
          this.form.permission_id=permission_id;
      }
   },
   created()  {
       this.$store.dispatch('user/fetchOne',this.$route.params.id);
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
        async updateUser () {
          if(Permissions.indexOf('edit users') == -1){
            Swal.fire({
              icon: 'error',
              title: 'Oops...',
              text: 'Bạn không có quyền sửa tài khoản!',
              })
        }else{
          this.form.name = this.data.user.name
          this.form.username = this.data.user.username
          this.form.email = this.data.user.email
          this.form.role_id = this.data.user.role.role_id
          this.form.address = this.data.user.address
          this.form.phone = this.data.user.phone
          this.form.gender = this.data.user.gender
          this.form.is_active = this.data.user.is_active
          await this.form.post(route('update.user',this.$route.params.id))
          .then(response => {
            if(response.data.status == 'success'){
              this.$router.push({ name: 'users' })
                Swal.fire(
                    'Đã cập nhật',
                    'Cập nhật tài khoản thành công!',
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
    updatePassword(){
        this.formPass.post(route('change.password',this.$route.params.id))
          .then(response => {
            if(response.data.status == 'success'){
              this.$router.push({ name: 'users' })
                Swal.fire(
                    'Update',
                    'Password update  Successfully',
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
    }
}
</script>

<style>

</style>