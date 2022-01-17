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
                    <form @submit.prevent="updateChallenge" @keydown="form.onKeydown($event)">
                        <div class="form-group row">
                            <label class="col-sm-2 col-form-label">Tiêu đề <span class="text-danger">*</span> : </label>
                            <div class="col-sm-10">
                                <input type="text" class="form-control" placeholder="Tiêu đề" name="title" v-model="data.title"
                                  :class="{'is-invalid': form.errors.has('title'),}"/>
                                <div class="text-danger" v-if="form.errors.has('title')" v-html="form.errors.get('title')"/>
                            </div>
                        </div>
                        <div class="form-group row">
                            <label class="col-sm-2 col-form-label">Mô tả <span class="text-danger">*</span> : </label>
                            <div class="col-sm-10">
                                <ckeditor name="description" v-model="data.description" :class="{ 'is-invalid': form.errors.has('description') }"></ckeditor>
                                <div class="text-danger" v-if="form.errors.has('description')" v-html="form.errors.get('description')" />
                            </div>
                        </div>
                        <div class="form-group row">
                            <label class="col-sm-2 col-form-label">Ngôn ngữ <span class="text-danger">*</span> : </label>
                            <div class="col-sm-10">
                               <input type="text" class="form-control" placeholder="Ngôn ngữ" name="language" v-model="data.language" :class="{
                                  'is-invalid': form.errors.has('language'), }"/>
                              <div class="text-danger" v-if="form.errors.has('language')" v-html="form.errors.get('language')" />
                            </div>
                        </div>
                        <div class="form-group row">
                            <label class="col-sm-2 col-form-label">Link figma nhúng <span class="text-danger">*</span> : </label>
                            <div class="col-sm-10">
                               <input type="text" class="form-control" placeholder="Link figma nhúng" name="link_figma" v-model="data.link_figma" :class="{
                                  'is-invalid': form.errors.has('link_figma'), }"/>
                              <div class="text-danger" v-if="form.errors.has('link_figma')" v-html="form.errors.get('link_figma')" />
                            </div>
                        </div>
                        <div class="form-group row">
                            <label class="col-sm-2 col-form-label">Thiết kế trên figma <span class="text-danger">*</span> : </label>
                            <div class="col-sm-10">
                               <input type="text" class="form-control" placeholder="Thiết kế trên figma" name="design_on_figma" v-model="data.design_on_figma" :class="{
                                  'is-invalid': form.errors.has('design_on_figma'), }"/>
                              <div class="text-danger" v-if="form.errors.has('design_on_figma')" v-html="form.errors.get('design_on_figma')" />
                            </div>
                        </div>
                        <div class="form-group row">
                            <label class="col-sm-2 col-form-label">Hình ảnh <span class="text-danger">*</span> : </label>
                            <div class="col-sm-10">
                               <input type="file" @change="uploadImage($event)" class="form-control" placeholder="Ảnh" name="image" :class="{
                                  'is-invalid': form.errors.has('image'), }"/>
                              <div class="text-danger" v-if="form.errors.has('image')" v-html="form.errors.get('image')" />
                              <img id="previewImg" :src="'/' + data.image" alt="" width="200" />
                            </div>
                        </div>
                        <div class="form-group row">
                            <label class="col-sm-2 col-form-label">Tài nguyên <span class="text-danger">*</span> : </label>
                            <div class="col-sm-10">
                               <input type="file" @change="uploadResources($event)" class="form-control" placeholder="Tài nguyên" name="resources"  :class="{
                                  'is-invalid': form.errors.has('resources'), }"/>
                              <div class="text-danger" v-if="form.errors.has('resources')" v-html="form.errors.get('resources')" />
                            </div>
                        </div>
                        <div class="form-group row">
                            <label class="col-sm-2 col-form-label">Cấp độ <span class="text-danger">*</span> : </label>
                            <div class="col-sm-10">
                               <select class="form-control select2" aria-label="Default select example" name="level"  v-model="data.level" :class="{ 'is-invalid': form.errors.has('level') }">
                                  <option value="">Chọn độ khó</option>
                                  <option value="1">Beginner</option>
                                  <option value="2">Elementary</option>
                                  <option value="3">Intermediate</option>
                                  <option value="4">Upper intermediate</option>
                                  <option value="5">Advanced</option>
                                  <option value="6">Proficient</option>
                                </select>
                                <div class="text-danger" v-if="form.errors.has('level')" v-html="form.errors.get('level')" />
                            </div>
                        </div>
                        <div class="form-group row">
                            <label class="col-sm-2 col-form-label">Danh mục <span class="text-danger">*</span> : </label>
                            <div class="col-sm-10">
                               <select  class="form-control select2" aria-label="Default select example"
                                name="cate_challen_id" v-model="data.cate_challen_id" :class="{'is-invalid': form.errors.has('cate_challen_id'), }">
                                <option value="">Chọn danh mục thử thách</option>
                                <option v-for="challengecategory in data.challengecategory"
                                  :key="challengecategory.id"
                                  :value="challengecategory.id">
                                  {{ challengecategory.name }}
                                </option>
                              </select>
                              <div class="text-danger"  v-if="form.errors.has('cate_challen_id')"
                                v-html="form.errors.get('cate_challen_id')"/>
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
      title: "",
      description: "",
      language: "",
      link_figma: "",
      design_on_figma:"",
      level: "",
      cate_challen_id: "",
    }),
    title: "Edit Challenge",
  }),
  computed: mapGetters({
    data: "challenge/challenge",
  }),
  components:{
    Footer
  },
  created() {
    this.$store.dispatch("challenge/fetchOne", this.$route.params.id);
  },
  methods: {
    uploadImage(event){
      var file = this.form.image = event.target.files[0];
        if(file){
            var reader = new FileReader();
            reader.onload = function(){
                $('#previewImg').attr("src",reader.result);
            }
            reader.readAsDataURL(file);
        }
    },
    uploadResources(event){
        this.form.resources = event.target.files[0];
    },
    async updateChallenge() {
       if(Permissions.indexOf('edit challenges') == -1){
            Swal.fire({
              icon: 'error',
              title: 'Oops...',
              text: 'Bạn không có quyền sửa thử thách!',
              })
        }else{
        this.form.title = this.data.title;
        this.form.description = this.data.description;
        this.form.language = this.data.language;
        this.form.link_figma = this.data.link_figma;
        this.form.design_on_figma = this.data.design_on_figma;
        this.form.level = this.data.level;
        this.form.cate_challen_id = this.data.cate_challen_id;
        await this.form
          .post(route("update.challenge", this.$route.params.id))
          .then((response) => {
            if (response.data.status == "success") {
              this.$router.push({ name: "challenges" });
              Swal.fire("Update", "Cập nhật thử thách thành công", "success");
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

<style>
</style>