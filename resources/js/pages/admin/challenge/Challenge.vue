<template>
  <div class="content-wrapper">
      <!-- START PAGE CONTENT-->
      <div class="page-heading row">
          <breadcrumb :title='title' class="col-6"></breadcrumb>
          <router-link v-if="$can('create challenges')" :to="{name:'add.challenge'}" class="col-6 text-right mt-5"><button type="button" class="btn btn-primary">Add New</button></router-link>
      </div>
      <div class="page-content fade-in-up">
        <div class="ibox">
              <div class="ibox-head">
                  <div class="ibox-title">{{title}}</div>
              </div>
              <div class="ibox-body">
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
      <Footer></Footer>
  </div>
</template>

<script>
import Footer from '../../../components/AdminFooter.vue';
import TableButton from '../../../components/TableButton.vue';
import ShowLevelComponent from '../../../components/ShowLevelComponent.vue';
import CheckboxTableComponent from '../../../components/CheckboxTableComponent.vue';
export default {
  data() {
    return {
      title: "Thử thách",
       data: {},
       form: new Form({
        challenge_id: [],
      }),
      tableProps: {
          search: '',
          length: 10,
          column: 'id',
          dir: 'asc'
      },
      columns: [
          {
              label: '<input type="checkbox" name="checkall" class="checkall">',
              component: CheckboxTableComponent,
              orderable: false,
          },
          {
              label: 'ID',
              name:'id',
              orderable: true,
          },
          {
              label: 'Tiêu đề',
              name: 'title',
              orderable: true,
          },
          {
              label: 'Ngôn ngữ',
              name: 'language',
              orderable: true,
          },
          {
              label: 'Danh mục',
              name: 'category.name',
              columnName: 'challenge_categories.name',
              orderable: true,
          },
          {
              label: 'Cấp độ',
              name: 'level',
              orderable: true,
              component: ShowLevelComponent,
          },
          {
              label: 'Action',
              name: 'edit.challenge',
              orderable: false,
              component: TableButton,
              event: "click",
              handler: this.deleteChallenge,
          }
      ]
    };
  },
   components:{
      Footer,
      TableButton,
      ShowLevelComponent,
      CheckboxTableComponent
  },
  created() {
     this.getData();
  },
  methods: {
    getData(url = route("challenges"), options = this.tableProps) {
        axios.get(url, {
            params: options
        })
        .then(response => {
          var result = response.data;
          for(var i in result['data']){
              result['data'][i].key=Number(i)+1;
          }
          this.data = result;
        })
        // eslint-disable-next-line
        .catch(errors => {
            //Handle Errors
        })
    },
    reloadTable(tableProps) {
        this.getData(route("challenges"), tableProps);
    },
 
    deleteChallenge(id) {
      Swal.fire({
        title: "Bạn có chắc?",
        text: "Bạn sẽ không thể hoàn tác!",
        icon: "warning",
        showCancelButton: true,
        confirmButtonColor: "#3085d6",
        cancelButtonColor: "#d33",
        confirmButtonText: "Xoá!",
      }).then((result) => {
           if(Permissions.indexOf('delete challenges') == -1){
                Swal.fire({
                    icon: 'error',
                    title: 'Oops...',
                    text: 'Bạn không có quyền xoá!',
                })
            }else{
                if (result.value) {
                //Send Request to server
                this.$store.dispatch("challenge/deletechallenge", id).then(
                    this.getData(route("challenges"), this.tableProps)
                )
                }
            }
      });
    },
    deleteAll(){
        var checkboxes = document.querySelectorAll('input[name="selected[]"]:checked');
        var selected = [];
        for (var i=0, n=checkboxes.length;i<n;i++) 
        {
            selected[i] = Number(checkboxes[i].value);
        } 
        this.form.challenge_id = selected
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
                if(Permissions.indexOf('delete challenges') == -1){
                    Swal.fire({
                        icon: 'error',
                        title: 'Oops...',
                        text: 'Bạn không có quyền xoá thử thách!',
                        })
                }else{
                    if (result.value) {
                        this.form.post(route('multiple.challenges'))
                        .then(response => {
                            if(response.data.status == 'success'){
                                 this.getData(route("challenges"), this.tableProps)
                                Swal.fire(
                                    'Đã xoá',
                                    'Xoá thử thách thành công!',
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
            })
        }else{
            Swal.fire({
                title: 'Chưa chọn thử thách',
                text: "Chưa có thử thách nào được chọn!",
                icon: 'warning',
            });
        }
      }
  }
};
</script>

<style>
</style>
