<template>
  <div class="content-wrapper">
      <!-- START PAGE CONTENT-->
      <div class="page-heading row">
          <breadcrumb :title='title' class="col-6"></breadcrumb>
          <router-link v-if="$can('create categories')" :to="{name:'add.challengecategory'}" class="col-6 text-right mt-5"><button type="button" class="btn btn-primary">Add New</button></router-link>
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
import ImageComponent from '../../../components/ImageComponent.vue';
import CheckboxTableComponent from '../../../components/CheckboxTableComponent.vue';

export default {
  data() {
    return {
      title: "Challenge Category",
       data: {},
       form: new Form({
        category_id: [],
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
              label: 'Tên',
              name: 'name',
              orderable: true,
              // columnName: name,
          },
          {
              label: 'Hình ảnh',
              orderable: false,
              component: ImageComponent,
              width: 10,
          },
          {
              label: 'Tổng số thử thách',
              name:'challenges.length',
              orderable: false,
          },
          {
              label: 'Action',
              name: 'edit.challengecategory',
              orderable: false,
              component: TableButton,
              event: "click",
              handler: this.deletechallengecategory,
          }
      ]
    };
  },
  components:{
    Footer,
    TableButton,
    ImageComponent,
    CheckboxTableComponent
  },
  created() {
        this.getData();
    },
  methods: {
    getData(url = route("challengecategories"), options = this.tableProps) {
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
        this.getData(route("challengecategories"), tableProps);
    },
    deletechallengecategory(id) {
      Swal.fire({
        title: "Bạn có chắc?",
        text: "Bạn sẽ không thể hoàn tác!",
        icon: "warning",
        showCancelButton: true,
        confirmButtonColor: "#3085d6",
        cancelButtonColor: "#d33",
        confirmButtonText: "Xoá!",
      }).then((result) => {
          if(Permissions.indexOf('delete categories') == -1){
                Swal.fire({
                    icon: 'error',
                    title: 'Oops...',
                    text: 'Bạn không có quyền xoá!',
                })
            }else{
                if (result.value) {
                //Send Request to server
                this.$store.dispatch("challengecategory/deletechallengecategory", id).then(
                            this.getData(route("challengecategories"), this.tableProps)
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
        this.form.category_id = selected
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
                if(Permissions.indexOf('delete categories') == -1){
                    Swal.fire({
                        icon: 'error',
                        title: 'Oops...',
                        text: 'Bạn không có quyền xoá danh mục!',
                        })
                }else{
                    if (result.value) {
                        this.form.post(route('multiple.categories'))
                        .then(response => {
                            if(response.data.status == 'success'){
                                this.getData(route("challengecategories"), this.tableProps)
                                Swal.fire(
                                    'Đã xoá',
                                    'Xoá danh mục thành công!',
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
                title: 'Chưa chọn danh mục',
                text: "Chưa có danh mục nào được chọn!",
                icon: 'warning',
            });
        }
      }
  }
};
</script>

<style>
</style>
