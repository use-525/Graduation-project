<template>
  <section class="content challenge">
    <div class="container">
      <div class="row figma-wrapper">
        <div class="col-12">
           <iframe class="figma"
            v-if="data"
              :src="data.link_figma"
              allowfullscreen
            />
        </div>
      </div>

      <div class="row">
        <div class="col-md-8 col-xs-12 col-lg-8 col-xl-8">
          <h1 class="challenge-title">{{ data.title }}</h1>

          <div
            v-if="data"
            v-html="data.description"
            class="challenge-detail challenge-block mb-4"
          ></div>

          <div class="challenge-require challenge-block">
            <p>
              Sau khi bạn hoàn thành, hãy gửi các giải pháp của bạn bằng cách cung cấp URL cho cả kho lưu trữ GitHub và ứng dụng trực tiếp trên bất kỳ nền tảng lưu trữ nào ( <a
                href="https://blogs.devchallenges.io/posts/tJ26U8MhZTPgBSRSwpqr" target="_blank"
                >5 Nền tảng lưu trữ miễn phí </a
              >) và giải thích ngắn gọn những gì bạn đã làm.
            </p>
            <p>
              Miễn là bạn hoàn thành tất cả các câu chuyện của người dùng, bạn có thể tạo dấu ấn cá nhân của mình bằng cách thêm chuyển tiếp, sử dụng hình ảnh của riêng bạn, thay đổi màu sắc, ...
            </p>
            <p>
              Hãy nhớ đặt tên của bạn ở chân trang để ngăn người khác gửi giải pháp của bạn.
            </p>
            <p>Bạn có thể kiểm tra các giải pháp của người khác và đưa ra phản hồi cho họ.</p>
          </div>
        </div>

        <div class="col-md-4 col-xs-12 col-lg-4 col-xl-4">
          <div v-if="check" class="challenge-instruction">
            <h4>Làm thế nào để bắt đầu</h4>
            <ol class="mt-4 mb-4">
              <li>Đọc mô tả chi tiết của thử thách</li>
              <li>Bắt đầu thử thách và tải xuống các tài nguyên <a :href="data.resources" download=""><svg class="MuiSvgIcon-root MuiSvgIcon-fontSizeInherit" focusable="false" viewBox="0 0 24 24" aria-hidden="true"><path d="M19 13v5c0 .55-.45 1-1 1H6c-.55 0-1-.45-1-1v-5c0-.55-.45-1-1-1s-1 .45-1 1v6c0 1.1.9 2 2 2h14c1.1 0 2-.9 2-2v-6c0-.55-.45-1-1-1s-1 .45-1 1zm-6-.33l1.88-1.88c.39-.39 1.02-.39 1.41 0 .39.39.39 1.02 0 1.41l-3.59 3.59c-.39.39-1.02.39-1.41 0L7.7 12.2a.9959.9959 0 010-1.41c.39-.39 1.02-.39 1.41 0L11 12.67V4c0-.55.45-1 1-1s1 .45 1 1v8.67z"></path></svg></a></li>
              <li>Kiểm tra thiết kế trên Figma</li>
              <li>Chúc bạn viết code vui vẻ !!</li>
            </ol>
            
            <a v-if="data.design_on_figma" :href="data.design_on_figma" target="_blank">
              <button class="button-block-chall" style="background: #8d99a7;">
                <img src="/images/figma.png" alt="" width="16">
              <span>Thiết kế</span>
            </button>
            </a>
             <router-link v-if="solution" :to="{name: 'showDetailSolution',params:{ id:solution.id}}">
               <button class="button-block-chall mt-2">
              <span>Xem giải pháp</span>
            </button>
            </router-link>
            <router-link v-else :to="{name: 'addSolution',params:{ id:data.slug}}">
               <button class="button-block-chall mt-2">
              <span>Gửi giải pháp</span>
            </button>
            </router-link>
           
          </div>
          <div v-else class="challenge-instruction">
            <h4>Làm thế nào để bắt đầu</h4>
            <ol class="mt-4 mb-4">
              <li>Đọc mô tả chi tiết của thử thách</li>
              <li>Bắt đầu thử thách và tải xuống các tài nguyên</li>
              <li>Kiểm tra thiết kế trên Figma</li>
              <li>Chúc bạn viết code vui vẻ !!</li>
            </ol>
            
            <a v-if="auth" :href="data.resources" download="">
              <button class="button-block-chall button-download" @click="downloadResource">
              <svg
                class="MuiSvgIcon-root MuiSvgIcon-fontSizeInherit"
                focusable="false"
                viewBox="0 0 24 24"
                aria-hidden="true"
              >
                <path
                  d="M16.59 9H15V4c0-.55-.45-1-1-1h-4c-.55 0-1 .45-1 1v5H7.41c-.89 0-1.34 1.08-.71 1.71l4.59 4.59c.39.39 1.02.39 1.41 0l4.59-4.59c.63-.63.19-1.71-.7-1.71zM5 19c0 .55.45 1 1 1h12c.55 0 1-.45 1-1s-.45-1-1-1H6c-.55 0-1 .45-1 1z"
                ></path>
              </svg>
              <span>Bắt đầu và tải xuống</span>
            </button>
            </a>
            <button v-else class="button-block-chall button-download" style="background-color:#868e96">
              <svg
                class="MuiSvgIcon-root MuiSvgIcon-fontSizeInherit"
                focusable="false"
                viewBox="0 0 24 24"
                aria-hidden="true"
              >
                <path
                  d="M16.59 9H15V4c0-.55-.45-1-1-1h-4c-.55 0-1 .45-1 1v5H7.41c-.89 0-1.34 1.08-.71 1.71l4.59 4.59c.39.39 1.02.39 1.41 0l4.59-4.59c.63-.63.19-1.71-.7-1.71zM5 19c0 .55.45 1 1 1h12c.55 0 1-.45 1-1s-.45-1-1-1H6c-.55 0-1 .45-1 1z"
                ></path>
              </svg>
              <span>Bắt đầu và tải xuống</span>
            </button>
          </div>
        </div>
      </div>
    </div>
  </section>
</template>

<script>

import { mapGetters } from "vuex";
export default {
  data: () => ({
    title: " Challenge",
    check: null
  }),
  computed: mapGetters({
    data: "challenge/challenge",
    auth: "auth/user",
    solution: "solution/solution"
  }),
  created() {
    this.$store.dispatch("challenge/fet_One_Data", this.$route.params.slug);
    this.$store.dispatch('auth/fetchUser');
    this.checkUserChall();
    this.$store.dispatch("challengecategory/getOneByChall",  this.$route.params.slug);
    this.$store.dispatch("solution/solutionChall", this.$route.params.slug);
  },
  methods: {
    downloadResource(){
      axios.post(route('challUser.challenge',this.data.id)).then(response => {
        this.check = response.data.data;
        })
        // eslint-disable-next-line
        .catch(errors => {
            //Handle Errors
        })
    },
    checkUserChall(){
      axios.get(route('check.challenge',this.$route.params.slug)).then(response => {
        this.check = response.data.data;
        })
        // eslint-disable-next-line
        .catch(errors => {
            //Handle Errors
        })
    }
  },
};
</script>

<style lang="scss">
@import "../../../sass/challenge.scss";
</style>
