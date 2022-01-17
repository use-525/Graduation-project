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
                  <div class="clf row">
                       <ul class="nav nav-tabs tabs-line-left col-2">
                          <li class="nav-item">
                              <a class="nav-link active" href="#tab-9-1" data-toggle="tab"><i class="fa fa-line-chart"></i> Thông tin cá nhân</a>
                          </li>
                          <li class="nav-item">
                              <a class="nav-link" href="#tab-9-3" data-toggle="tab"><i class="ti-write"></i> Đổi mật khẩu</a>
                          </li>
                      </ul>
                      <div class="tab-content col-9" v-if="user">
                          <div class="tab-pane fade show active" id="tab-9-1">
                                <form @submit.prevent="updateProfile"  @keydown="form.onKeydown($event)" class="form-horizontal">
                                    <div class="form-group row">
                                        <label for="" class="col-sm-2 col-form-label">Username <span class="text-danger">*</span> : </label>
                                        <div class="col-sm-10">
                                            <input type="text" v-model="user.username" :class="{ 'is-invalid': form.errors.has('username') }" class="form-control" name="username" placeholder="Enter username">
                                            <div class="text-danger" v-if="form.errors.has('username')" v-html="form.errors.get('username')" />
                                        </div>
                                    </div>
                                    <div class="form-group row">
                                        <label for="" class="col-sm-2 col-form-label">Name <span class="text-danger">*</span> : </label>
                                        <div class="col-sm-10">
                                            <input type="text" v-model="user.name" :class="{ 'is-invalid': form.errors.has('name') }" class="form-control" name="username" placeholder="Enter name">
                                            <div class="text-danger" v-if="form.errors.has('name')" v-html="form.errors.get('name')" />
                                        </div>
                                    </div>
                                    <div class="form-group row">
                                        <label for="" class="col-sm-2 col-form-label">Email <span class="text-danger">*</span> : </label>
                                        <div class="col-sm-10">
                                            <input type="email" v-model="user.email" :class="{ 'is-invalid': form.errors.has('email') }" class="form-control" name="email" placeholder="Enter email">
                                            <div class="text-danger" v-if="form.errors.has('email')" v-html="form.errors.get('email')" />
                                        </div>
                                    </div>
                                    <div class="form-group row">
                                        <label for="" class="col-sm-2 col-form-label">Ảnh:</label>
                                        <div class="col-sm-10">
                                        <input type="file" @change="upload($event)" :class="{ 'is-invalid': form.errors.has('image') }" class="form-control" name="image">
                                        <div class="text-danger" v-if="form.errors.has('image')" v-html="form.errors.get('image')" />
                                        <img id="previewImg" :src="'/'+user.image" alt="" width="200">
                                        </div>
                                    </div>
                                  
                                    <div class="form-group row">
                                        <label for="" class="col-sm-2 col-form-label">Địa chỉ:</label>
                                        <div class="col-sm-10">
                                        <input type="text" class="form-control" v-model="user.address" :class="{ 'is-invalid': form.errors.has('address') }" placeholder="Enter address">
                                        <div class="text-danger" v-if="form.errors.has('address')" v-html="form.errors.get('address')" />
                                        </div>
                                    </div>
                                    <div class="form-group row">
                                        <label for="" class="col-sm-2 col-form-label">Số điện thoại <span class="text-danger">*</span> : </label>
                                        <div class="col-sm-10">
                                        <input type="text" class="form-control" :class="{ 'is-invalid': form.errors.has('phone') }" v-model="user.phone" placeholder="Enter phone">
                                        <div class="text-danger" v-if="form.errors.has('phone')" v-html="form.errors.get('phone')" />
                                        </div>
                                    </div>
                                    <div class="form-group row">
                                        <label for="" class="col-sm-2 col-form-label">Gender:</label>
                                        <div class="col-md-10">
                                        <label class="ui-radio ui-radio-primary mr-3" for="male">
                                            <input type="radio" name="gender" :value="1" id="male" v-model="user.gender">
                                            <span class="input-span"></span>Nam</label>
                                        <label class="ui-radio ui-radio-primary" for="female">
                                            <input type="radio" name="gender" :value="0" id="female" v-model="user.gender">
                                            <span class="input-span"></span>Nữ</label>
                                        <div class="text-danger" v-if="form.errors.has('gender')" v-html="form.errors.get('gender')" />
                                        </div>
                                    </div>
                                    <div class="form-group row">
                                      <label for="" class="col-sm-2 col-form-label">Github:</label>
                                      <div class="col-sm-10">
                                          <p v-if="user.github_url" v-html="user.github_url"></p>
                                          <p v-else>Link github</p>
                                      </div>
                                  </div>
                                    <div class="form-group row">
                                    <div class="col-sm-10 ml-sm-auto">
                                        <button class="btn btn-info" type="submit">Cập nhật</button>
                                    </div>
                                    </div>
                                </form>
                          </div>
                          <div class="tab-pane" id="tab-9-3">
                            <form @submit.prevent="updatePassword"  @keydown="form.onKeydown($event)" class="form-horizontal">
                              <div class="form-group row">
                                <label for="" class="col-sm-2 col-form-label">Mật khẩu hiện tại <span class="text-danger">*</span> : </label>
                                <div class="col-sm-10">
                                  <input type="password" v-model="formPass.password" :class="{ 'is-invalid': formPass.errors.has('password') }" class="form-control" name="username" placeholder="Enter name">
                                  <div class="text-danger" v-if="formPass.errors.has('password')" v-html="formPass.errors.get('password')" />
                                </div>
                              </div>
                              <div class="form-group row">
                                <label for="" class="col-sm-2 col-form-label">Mật khẩu mới <span class="text-danger">*</span> : </label>
                                <div class="col-sm-10">
                                  <input type="password" v-model="formPass.new_password" :class="{ 'is-invalid': formPass.errors.has('new_password') }" class="form-control" name="username" placeholder="Enter name">
                                  <div class="text-danger" v-if="formPass.errors.has('new_password')" v-html="formPass.errors.get('new_password')" />
                                </div>
                              </div>
                              <div class="form-group row">
                                <label for="" class="col-sm-2 col-form-label">Xác nhận mật khẩu mới <span class="text-danger">*</span> : </label>
                                <div class="col-sm-10">
                                  <input type="password" v-model="formPass.new_confirm_password" :class="{ 'is-invalid': formPass.errors.has('new_confirm_password') }" class="form-control" name="username" placeholder="Enter name">
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
      address: '',
      password:'',
      phone: '',
      gender: '',
    }),
    formPass: new Form({
      password: '',
      new_password: '',
      new_confirm_password: ''
    }),
    title: 'Chỉnh sửa hồ sơ',
  }),
  components:{
    Footer
  },
   computed: {
      user () {
          return this.$store.state.auth.user;
      },
   },
   created()  {
       this.$store.dispatch('auth/fetchUser');
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
        async updateProfile () {
          this.form.name = this.user.name
          this.form.username = this.user.username
          this.form.email = this.user.email
          this.form.address = this.user.address
          this.form.phone = this.user.phone
          this.form.gender = this.user.gender
       await this.form.post(route('profile.user',this.user.id))
      .then(response => {
        if(response.data.status == 'success'){
           this.$router.push({ name: 'users' })
            Swal.fire(
                'Update',
                'User update  Successfully',
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
    },
    updatePassword(){
      this.formPass.post(route('change.password',this.user.id))
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