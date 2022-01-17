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
                    <form @submit.prevent="updateChallengeCategory" @keydown="form.onKeydown($event)">
                        <div class="form-group row">
                            <label class="col-sm-2 col-form-label">Tên<span class="text-danger">*</span> : </label>
                            <div class="col-sm-10">
                                 <input v-model="data.name" :class="{ 'is-invalid': form.errors.has('name'),}" class="form-control" type="text" name="name" />
                                <div class="text-danger" v-if="form.errors.has('name')" v-html="form.errors.get('name')" />
                            </div>
                        </div>
                        <div class="form-group row">
                            <label class="col-sm-2 col-form-label">Mô tả<span class="text-danger">*</span> : </label>
                            <div class="col-sm-10">
                                <ckeditor v-model="data.description" :class="{'is-invalid': form.errors.has('description'),}" name="description"></ckeditor>
                                <div  class="text-danger" v-if="form.errors.has('description')"
                                  v-html="form.errors.get('description')"/>
                            </div>
                        </div>
                        <div class="form-group row">
                            <label class="col-sm-2 col-form-label">Quy tắc<span class="text-danger">*</span> : </label>
                            <div class="col-sm-10">
                                <ckeditor v-model="data.rule" :class="{'is-invalid': form.errors.has('rule'),}" name="rule"></ckeditor>
                                <div  class="text-danger" v-if="form.errors.has('rule')"
                                  v-html="form.errors.get('rule')"/>
                            </div>
                        </div>
                        <div class="form-group row">
                            <label class="col-sm-2 col-form-label">Ảnh<span class="text-danger">*</span> : </label>
                            <div class="col-sm-10">
                               <input type="file" @change="upload($event)"
                                :class="{'is-invalid': form.errors.has('image'),}"
                                class="form-control" name="image"/>
                              <div class="text-danger" v-if="form.errors.has('image')" v-html="form.errors.get('image')" />
                              <img id="previewImg" :src="'/' + data.image" alt="" width="200" />
                            </div>
                        </div>
                        <div class="form-group row">
                            <div class="col-sm-10 ml-sm-auto">
                                <button class="btn btn-info" type="submit">Cập nhật</button>
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
import Footer from '../../../components/AdminFooter.vue';
import { mapGetters } from "vuex";
export default {
  data: () => ({
    form: new Form({
      name: "",
      description: "",
      rule: "",
      image: "",
    }),
    title: "Cập nhật danh mục",
  }),
  components:{
    Footer
  },
  computed: mapGetters({
    data: "challengecategory/challengecategory",
  }),
  created() {
    this.$store.dispatch("challengecategory/fetchOne", this.$route.params.id);
  },
  methods: {
    upload(event) {
       var file = this.form.image = event.target.files[0];
            if(file){
                var reader = new FileReader();
                reader.onload = function(){
                    $('#previewImg').attr("src",reader.result);
                }
                reader.readAsDataURL(file);
            }
    },
    async updateChallengeCategory() {
      if(Permissions.indexOf('edit categories') == -1){
            Swal.fire({
              icon: 'error',
              title: 'Oops...',
              text: 'Bạn không có quyền sửa danh mục!',
              })
        }else{
      this.form.name = this.data.name;
      this.form.rule = this.data.rule;
      this.form.description = this.data.description;
      await this.form
        .post(route("update.challengecategory", this.$route.params.id))
        .then((response) => {
          if (response.data.status == "success") {
            this.$router.push({ name: "challengecategories" });
            Swal.fire(
              "Update",
              "Cập nhật danh mục thành công",
              "success"
            );
          }
        })
        .catch(() => {
          Swal.fire({
            icon: "error",
            title: "Oops...",
            text: "Đã  xảy ra lỗi!",
          });
        });
      }
    },
  },
};
</script>

<style></style>
