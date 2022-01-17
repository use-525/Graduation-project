<template>
  <section class="content challenge">
    <div class="container">
      <div class="row">
          <div class="col-12">
            <div class="row solution-add">
                <div class="col-4">
                    <router-link :to="{name: 'chanllenge',params:{ slug:challenge.slug}}">
                        <img :src="'/'+challenge.image" alt="">
                    </router-link>
                </div>
                <div class="col-8">
                    <h4 class="mb-3">{{challenge.title}}</h4>
                    <p><i class="ti-check text-success"></i> Đảm bảo hoàn thành các yêu cầu của người dùng</p>
                    <p><i class="ti-check text-success"></i> Bao gồm cả URL demo và URL kho lưu trữ</p>
                    <p><i class="ti-check text-success"></i> Cố gắng giải thích cách tiếp cận của bạn một cách ngắn gọn</p>
                </div>
            </div>         
          </div>
      </div>

      <div class="row">
        <div class="col-md-8">
          <!-- jquery validation -->
          <div class="card card-primary">
            <div class="card-header">
              <h3 class="card-title">{{ title }}</h3>
            </div>
            <!-- /.card-header -->
            <!-- form start -->
            <form
              @submit.prevent="submitSolution"
              @keydown="form.onKeydown($event)"
            >
              <div class="card-body">
                <div class="form-group">
                  <label for="">Tiêu đề:</label>
                  <input
                    type="text"
                    class="form-control"
                    placeholder="Title"
                    name="title"
                    v-model="solution.title"
                    :class="{
                      'is-invalid': form.errors.has('title'),
                    }"
                  />
                  <div
                    class="text-danger"
                    v-if="form.errors.has('title')"
                    v-html="form.errors.get('title')"
                  />
                </div>
                <div class="form-group">
                  <label for="">Chi tiết:</label>
                  <ckeditor
                    name="description"
                    v-model="solution.description"
                    :class="{ 'is-invalid': form.errors.has('description') }"
                  ></ckeditor>
                   <div
                    class="text-danger"
                    v-if="form.errors.has('description')"
                    v-html="form.errors.get('description')"
                  />
                </div>

                <div class="form-group">
                  <label for="">Link GitHub:</label>
                  <input
                    type="text"
                    class="form-control"
                    placeholder="Link GitHub"
                    name="link_github"
                    v-model="solution.link_github"
                    :class="{ 'is-invalid': form.errors.has('link_github') }"
                  />
                  <div
                    class="text-danger"
                    v-if="form.errors.has('link_github')"
                    v-html="form.errors.get('link_github')"
                  />
                </div>
                <div class="form-group">
                  <label for="">Link Demo:</label>
                  <input
                    type="text"
                    class="form-control"
                    placeholder="Link Demo"
                    name="demo_url"
                    v-model="solution.demo_url"
                    :class="{ 'is-invalid': form.errors.has('demo_url') }"
                  />
                  <div
                    class="text-danger"
                    v-if="form.errors.has('demo_url')"
                    v-html="form.errors.get('demo_url')"
                  />
                </div>
              </div>
              <!-- /.card-body -->
              <div class="card-footer text-right">
                <button type="submit" class="btn btn-primary">Gửi đi</button>
              </div>
            </form>
          </div>
          <!-- /.card -->
        </div>
      </div>
    </div>
  </section>
</template>


<script>
import { mapGetters } from "vuex";
import axios from "axios";
export default {
  data: () => ({
    form: new Form({
      title: "",
      description: "",
      link_github: "",
      demo_url: "",
      challen_id: "",
      id:''
    }),
    title: "Gửi giải pháp",
  }),
  computed: mapGetters({
    challenge: "challenge/challenge",
    solution: "solution/solution"
  }),
  created() {
    this.$store.dispatch("challenge/fet_One_Data", this.$route.params.slug);
    this.$store.dispatch("solution/solutionChall", this.$route.params.slug);
    this.$store.dispatch("challengecategory/getOneByChall",  this.$route.params.slug);
  },
  methods: {
    async submitSolution() {
      this.form.title = this.solution.title;
      this.form.description = this.solution.description;
      this.form.link_github = this.solution.link_github;
      this.form.demo_url = this.solution.demo_url;
      this.form.challen_id = this.challenge.id;
      this.form.id = this.solution.id;
        await this.form
          .post(route("edit.solution",this.$route.params.slug))
          .then((response) => {
            console.log(response);
            this.$router.push({ name: "showDetailSolution", params: { id: response.data.data.id }});
          })
          .catch(() => {
            Swal.fire({
              icon: "error",
              title: "Oops...",
              text: "Something went wrong!",
            });
          });
    },
  },
};
</script>

<style lang="scss">
@import "../../../sass/challenge.scss";
.solution-add{
    background: #f1f1f1;
    border-radius: 5px;
    padding: 10px;
    margin: 30px 0;
}
</style>
