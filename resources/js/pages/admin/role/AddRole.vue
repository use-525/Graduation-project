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
                    <form @submit.prevent="addRole" @keydown="form.onKeydown($event)" class="form-horizontal row">
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
                                <label for="" class="col-sm-2 col-form-label">Name <span class="text-danger">*</span> : </label>
                                <div class="col-sm-10">
                                    <input type="text" v-model="form.name" :class="{ 'is-invalid': form.errors.has('name') }"  class="form-control"  placeholder="Enter name">
                                    <div class="text-danger" v-if="form.errors.has('name')" v-html="form.errors.get('name')" />
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
    title: 'Add role',
  }),
   components:{
      Footer
  },
   computed: {
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
      this.$store.dispatch('permission/all');
  },
  methods: {
   
    async addRole () {
        if(Permissions.indexOf('create roles') == -1){
        Swal.fire({
            icon: 'error',
            title: 'Oops...',
            text: 'Bạn không có quyền thêm vai trò!',
            })
        }else{
            await this.form.post(route('create.role'))
            .then(response => {
                if(response.data.status == 'success'){
                this.$router.push({ name: 'roles' })
                    Swal.fire(
                        'Created',
                        'Thêm vai trò thành công!',
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