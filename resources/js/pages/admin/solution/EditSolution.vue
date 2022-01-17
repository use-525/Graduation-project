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
                </div>
                <div class="ibox-body">
                  <div class="clf row">
                       <ul class="nav nav-tabs tabs-line-left col-2">
                          <li class="nav-item">
                              <a class="nav-link active" href="#tab-9-1" data-toggle="tab"><i class="fa fa-line-chart"></i> Tổng quan</a>
                          </li>
                          <li class="nav-item">
                              <a class="nav-link" href="#tab-9-2" data-toggle="tab"><i class="ti-comment-alt"></i> Bình luận</a>
                          </li>
                      </ul>
                      <div class="tab-content col-9">

                          <div class="tab-pane fade show active" id="tab-9-1">
                            <form @submit.prevent="updateSolution" @keydown="form.onKeydown($event)" class="form-horizontal">
                              <div class="form-group row">
                                  <label for="" class="col-sm-2 col-form-label">Tiêu đề <span class="text-danger">*</span> : </label>
                                  <div class="col-sm-10">
                                      <input type="text" v-model="data.title" :class="{ 'is-invalid': form.errors.has('title') }"  class="form-control" placeholder="Nhập tiêu đề">
                                      <div class="text-danger" v-if="form.errors.has('title')" v-html="form.errors.get('title')" />
                                  </div>
                              </div>
                              <div class="form-group row">
                                  <label for="" class="col-sm-2 col-form-label">Link demo <span class="text-danger">*</span> : </label>
                                  <div class="col-sm-10">
                                      <input type="text" v-model="data.demo_url" :class="{ 'is-invalid': form.errors.has('demo_url') }"  class="form-control" placeholder="Nhập tiêu đề">
                                      <div class="text-danger" v-if="form.errors.has('demo_url')" v-html="form.errors.get('demo_url')" />
                                  </div>
                              </div>
                              <div class="form-group row">
                                  <label for="" class="col-sm-2 col-form-label">Link github <span class="text-danger">*</span> : </label>
                                  <div class="col-sm-10">
                                      <input type="text" v-model="data.link_github" :class="{ 'is-invalid': form.errors.has('link_github') }"  class="form-control" placeholder="Nhập tiêu đề">
                                      <div class="text-danger" v-if="form.errors.has('link_github')" v-html="form.errors.get('link_github')" />
                                  </div>
                              </div>
                              <div class="form-group row">
                                  <label for="" class="col-sm-2 col-form-label">Thử thách <span class="text-danger">*</span> : </label>
                                  <div class="col-sm-10">
                                      <select  class="form-control select2" aria-label="Default select example"
                                        name="challen_id" v-model="data.challen_id" :class="{'is-invalid': form.errors.has('challen_id'), }">
                                        <option v-for="challenge in data.challenges"
                                          :key="challenge.id"
                                          :value="challenge.id">
                                          {{ challenge.title }}
                                        </option>
                                      </select>
                                      <div class="text-danger"  v-if="form.errors.has('challen_id')"
                                        v-html="form.errors.get('challen_id')"/>
                                  </div>
                              </div>
                              <div class="form-group row">
                                  <label for="" class="col-sm-2 col-form-label">Mô tả <span class="text-danger">*</span> : </label>
                                  <div class="col-sm-10">
                                      <ckeditor v-model="data.description" :class="{'is-invalid': form.errors.has('description'),}" name="description"></ckeditor>
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
                          <div class="tab-pane" id="tab-9-2">
                           <form  @submit.prevent="deleteAll" @keydown="form.onKeydown($event)" class="form-table">
                                <button type="submit" class="btn btn-gray delete-mul">Xoá mục đánh dấu</button>
                                <data-table  :data="data"
                                    :columns="columns"
                                    @on-table-props-changed="reloadTable"
                                    class="table table-head-fixed text-nowrap">
                                </data-table>
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
import { mapGetters } from "vuex";
import TableButton from '../../../components/TableButton.vue';
import ApprovedFeedback from '../../../components/ApprovedFeedback.vue';
import CheckboxTableComponent from '../../../components/CheckboxTableComponent.vue';

export default {
   data() {
   return {
      form: new Form({
      title: '',
      demo_url: '',
      link_github: '',
      description: '',
      challen_id: '',
    }),
     formFeedback: new Form({
        feedback_id: [],
      }),
    title: 'Chi tiết giải pháp',
    feedback: {},
      tableProps: {
          search: '',
          length: 10,
          column: 'id',
          dir: 'desc'
      },
      columns: [
           {
              label: '<input type="checkbox" name="checkall" class="checkall">',
              component: CheckboxTableComponent,
              orderable: false,
          },
          {
              label: 'STT',
              name:'key',
              orderable: false,
          },
           {
              label: 'Nội dung',
              name: 'feedback_content',
              orderable: true,
              width: 10,
          },
          {
              label: 'Họ tên',
              name: 'users.name',
              columnName: 'users.name',
              orderable: true,
          },
          
          {
              label: 'Phê duyệt',
              name: 'is_approved',
              component: ApprovedFeedback,
              orderable: true,
              event: "click",
              handler: this.updateApproved,
          },
          {
              label: 'Action',
              name: 'add.feedback',
              orderable: false,
              component: TableButton,
              event: "click",
              handler: this.deleteFeedback,
          }
      ]
   }
  },
   components:{
      Footer,
      TableButton,
      ApprovedFeedback,
      CheckboxTableComponent
  },
   computed: mapGetters({
    data: "solution/solution",
  }),
  created: function () {
      this.getData();
      this.$store.dispatch("solution/fetchOne", this.$route.params.id);
  },
  methods: {
    async updateSolution () {
         if(Permissions.indexOf('edit solutions') == -1){
            Swal.fire({
              icon: 'error',
              title: 'Oops...',
              text: 'Bạn không có quyền sửa giải pháp!',
              })
        }else{
        this.form.title = this.data.title;
        this.form.demo_url = this.data.demo_url;
        this.form.link_github = this.data.link_github;
        this.form.description = this.data.description;
        this.form.challen_id = this.data.challen_id;
        await this.form.post(route('update.solution',this.$route.params.id))
        .then(response => {
            if(response.data.status == 'success'){
            this.$router.push({ name: 'solutions' })
                Swal.fire(
                    'Thành công',
                    'Cập nhật giải pháp thành công.',
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
    getData(url = route("solution.feedback",this.$route.params.id), options = this.tableProps) {
            axios.get(url, {
                params: options
            })
            .then(response => {
               var result = response.data;
                for(var i in result['data']){
                    result['data'][i].key=Number(i)+1;
                }
                this.feedback = result;
            })
            // eslint-disable-next-line
            .catch(errors => {
                //Handle Errors
            })
        },
        reloadTable(tableProps) {
            this.getData(route("solution.feedback",this.$route.params.id), tableProps);
        },   
        updateApproved(id){
            this.$store.dispatch('feedback/updateApproved', id).then(
                this.getData(route("solution.feedback",this.$route.params.id), this.tableProps)
            )
        },
        deleteFeedback(id) {
            Swal.fire({
              title: 'Bạn có chắc?',
              text: "Bạn sẽ không thể hoàn tác!",
              icon: 'warning',
              showCancelButton: true,
              confirmButtonColor: '#3085d6',
              cancelButtonColor: '#d33',
              confirmButtonText: 'Xoá!'
            }).then((result) => {

              if (result.value) {
                //Send Request to server
                this.$store.dispatch('feedback/deleteFeedback', id).then(
                    this.getData(route("solution.feedback",this.$route.params.id), this.tableProps)
                )
                }

            })
          },
          deleteAll(){
        var checkboxes = document.querySelectorAll('input[name="selected[]"]:checked');
        var selected = [];
        for (var i=0, n=checkboxes.length;i<n;i++) 
        {
            selected[i] = Number(checkboxes[i].value);
        } 
        this.formFeedback.feedback_id = selected
        if(selected.length>0){
            Swal.fire({
            title: 'Bạn có chắc?',
            text: "Bạn sẽ không thể hoàn tác!",
            icon: 'warning',
            showCancelButton: true,
            confirmButtonColor: '#3085d6',
            cancelButtonColor: '#d33',
            confirmButtonText: 'Xoá!'
            }).then((result) => {
                if (result.value) {
                    this.formFeedback.post(route('multiple.feedbacks'))
                    .then(response => {
                        if(response.data.status == 'success'){
                            this.getData(route("solution.feedback",this.$route.params.id), this.tableProps)
                            Swal.fire(
                                'Đã xoá',
                                'Xoá bình luận thành công!',
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
            })
        }else{
            Swal.fire({
                title: 'Chưa chọn bình luận',
                text: "Chưa có bình luận nào được chọn!",
                icon: 'warning',
            });
        }
      }
  }
}
</script>

<style>

</style>