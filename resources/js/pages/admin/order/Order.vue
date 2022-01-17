<template>
    <div class="content-wrapper">
      <!-- START PAGE CONTENT-->
      <div class="page-heading row">
          <breadcrumb :title='title' class="col-6"></breadcrumb>
          <router-link v-if="$can('create orders')" :to="{name:'add.order'}" class="col-6 text-right mt-5"><button type="button" class="btn btn-primary">Add New</button></router-link>
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
import CheckboxTableComponent from '../../../components/CheckboxTableComponent.vue';

export default {
   data() {
    return {
     title: 'Hoá đơn',
     data: {},
     form: new Form({
        order_id: [],
      }),
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
              name: 'key',
              orderable: true,
          },
          {
              label: 'Mã hoá đơn',
              name: 'order_nr',
              orderable: true,
          },
          {
              label: 'Họ tên',
              name: 'user.name',
              orderable: true,
          },
          {
              label: 'upgrade',
              name: 'upgrade.name',
              orderable: true,
          },
          {
              label: 'Thời hạn',
              name: 'expiration',
              orderable: true,
          },
          {
              label: 'Trạng thái',
              name: 'status',
              orderable: true,
          },
           {
              label: 'Action',
              name: 'edit.order',
              orderable: false,
              component: TableButton,
              event: "click",
              handler: this.deleteOrder,
          }
      ]
    };
  },
   components:{
      Footer,
      TableButton,
      CheckboxTableComponent
  },
    created() {
        this.getData();
    },
    methods: {
      async  getData(url = route("orders"), options = this.tableProps) {
           await axios.get(url, {
                params: options
            })
            .then(response => {
                var result = response.data;
                for(var i in result['data']){
                    result['data'][i].key=Number(i)+1;
                    switch (result['data'][i].status) {
                        case 0:
                            result['data'][i].status = "Chờ Thanh Toán";
                            break;
                        case 1:
                            result['data'][i].status = "Thành Công";
                            break;
                            case 2:
                            result['data'][i].status = "Lỗi";
                            break;
                        default:
                            break;
                    }
                }
                // console.log(result.data);
                this.data = result;
            })
            // eslint-disable-next-line
            .catch(errors => {
                //Handle Errors
            })
        },
        reloadTable(tableProps) {
            this.getData(route("orders"), tableProps);
        },
         deleteOrder: function (id) {
             Swal.fire({
              title: 'Bạn có chắc?',
              text: "Bạn sẽ không thể hoàn tác!",
              icon: 'warning',
              showCancelButton: true,
              confirmButtonColor: '#3085d6',
              cancelButtonColor: '#d33',
              confirmButtonText: 'Xoá!'
            }).then((result) => {
                if(Permissions.indexOf('delete orders') == -1){
                    Swal.fire({
                        icon: 'error',
                        title: 'Oops...',
                        text: 'Bạn không có quyền xoá!',
                    })
                }else{
                    if (result.value) {
                        //Send Request to server
                        this.$store.dispatch('order/deleteOrder', id).then(
                            this.getData(route("orders"), this.tableProps)
                        )
                    }
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
        this.form.order_id = selected
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
                if(Permissions.indexOf('delete orders') == -1){
                    Swal.fire({
                        icon: 'error',
                        title: 'Oops...',
                        text: 'Bạn không có quyền xoá hoá đơn!',
                        })
                }else{
                    if (result.value) {
                        this.form.post(route('multiple.orders'))
                        .then(response => {
                            if(response.data.status == 'success'){
                               this.getData(route("orders"), this.tableProps)
                                Swal.fire(
                                    'Đã xoá',
                                    'Xoá hoá đơn thành công!',
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
                title: 'Chưa chọn hoá đơn',
                text: "Chưa có hoá đơn nào được chọn!",
                icon: 'warning',
            });
        }
      }
    },
    
}
</script>

<style>

</style>
