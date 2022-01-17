
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
                    <form @submit.prevent="updateRole" @keydown="form.onKeydown($event)" class="form-horizontal row">
                       <ul class="nav nav-tabs tabs-line-left col-2">
                          <li class="nav-item">
                              <a class="nav-link active" href="#tab-9-1" data-toggle="tab"><i class="fa fa-line-chart"></i> Tổng quan</a>
                          </li>
                          <li class="nav-item">
                              <a class="nav-link" href="#tab-9-2" data-toggle="tab"><i class="fa fa-heartbeat"></i> Quyền hạn</a>
                          </li>
                      </ul>
                      <div class="tab-content col-9" v-if="data.role">
                          <div class="tab-pane fade show active" id="tab-9-1">
                              <div class="form-group row">
                                  <label for="" class="col-sm-2 col-form-label">Name <span class="text-danger">*</span> : </label>
                                  <div class="col-sm-10">
                                      <input type="text"  v-model="data.role.name" :class="{ 'is-invalid': form.errors.has('name') }"  class="form-control" placeholder="Enter role">
                                        <div class="text-danger" v-if="form.errors.has('name')" v-html="form.errors.get('name')"></div>
                                  </div>
                              </div>
                            <div class="form-group row">
                              <div class="col-sm-10 ml-sm-auto">
                                  <button class="btn btn-info" type="submit">Submit</button>
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
      name: '',
      permission_id: []
    }),
    title: 'Edit role',
  }),
  components:{
    Footer
  },
   computed: {
        data () {
            return this.$store.state.role.role;
        },
        
        permission_id (){
          var permission_id = [];
          if(this.data.role.role_has_permissions.length>0){
             this.data.role.role_has_permissions.forEach(function (permission) {
                permission_id.push(permission.permission_id);
            });
          }
           return this.form.permission_id=permission_id;
        }
   },
  created: function () {
     this.$store.dispatch('role/fetchOne',this.$route.params.id);
  },
  methods: {
  
    async updateRole () {
       if(Permissions.indexOf('edit roles') == -1){
            Swal.fire({
              icon: 'error',
              title: 'Oops...',
              text: 'Bạn không có quyền sửa vai trò!',
              })
       }else{
        this.form.name = this.data.role.name;
        // this.form.permission_id = this.permission_id;
        await this.form.post(route('update.role',this.$route.params.id))
        .then(response => {
            if(response.data.status == 'success'){
              this.$router.push({ name: 'roles' })
                Swal.fire(
                    'update',
                    'Cập nhật vai trò thành công!',
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
}
</script>

<style>

</style>