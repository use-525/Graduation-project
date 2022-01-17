<template>
  <div class="content">
    <div class="container">
      <div class="dashboard-title">
        <h1>Tổng quan</h1>
      </div>
      <div class="row">
        <div class="select-box col-lg-4" v-if="data.challenges">
          <div
            v-if="data.challenges.length > 0"
            class="lastest-tutorial-content"
          >
            <h5 class="pb-3">Dự án đang thực hiện</h5>
            <div
              class="row mb-3"
              v-for="(challenge,index) in data.challenges"
              :key="index"
            >
              <div class="col-4">
                <router-link
                  :to="{ name: 'chanllenge', params: { slug: challenge.slug } }"
                  ><img :src="'/' + challenge.image" alt=""
                /></router-link>
              </div>
              <div class="col-8">
                <router-link
                  :to="{ name: 'chanllenge', params: { slug: challenge.slug } }"
                  ><p>{{ challenge.title }}</p></router-link
                >
              </div>
            </div>
          </div>
          <div v-else class="select-box-content">
            <div class="image">
              <img src="images/solutions.png" alt="" />
            </div>
            <div class="desc-select text-center">Bạn không có dự án nào</div>
            <div class="select-button text-center">
              <router-link :to="{ name: 'home' }"
                ><button>Chọn một thử thách</button></router-link
              >
            </div>
          </div>
          <div v-if="data.solutions && data.solutions.length>0" class="lastest-tutorial-content mt-5">
            <h5>Giải pháp</h5>
            <!-- <div class="reputations">
              <span class="reputations-value">0 </span>
              <span class="reputations-text">Giải pháp</span>
            </div> -->
            <div
              class="row mb-3"
              v-for="solution in data.solutions"
              :key="solution.id"
            >
              <div class="col-4" v-if="solution.challenge">
                <router-link
                  :to="{
                    name: 'showDetailSolution',
                    params: { id: solution.id },
                  }"
                  ><img :src="'/' + solution.challenge.image" alt=""
                /></router-link>
              </div>
              <div class="col-8">
                <router-link
                  :to="{
                    name: 'showDetailSolution',
                    params: { id: solution.id },
                  }"
                  ><p>{{ solution.title }}</p></router-link
                >
                <p>
                  <span v-if="solution.upvote" class="mr-3"
                    ><svg
                      class="MuiSvgIcon-root MuiSvgIcon-fontSizeInherit"
                      focusable="false"
                      viewBox="0 0 24 24"
                      aria-hidden="true"
                      style="transform: rotate(-90deg)"
                    >
                      <path
                        d="M8 6.82v10.36c0 .79.87 1.27 1.54.84l8.14-5.18c.62-.39.62-1.29 0-1.69L9.54 5.98C8.87 5.55 8 6.03 8 6.82z"
                      ></path></svg
                    >{{ solution.upvote.length }}</span
                  >
                  <span v-if="solution.feedbacks"
                    ><svg
                      class="MuiSvgIcon-root MuiSvgIcon-fontSizeInherit"
                      focusable="false"
                      viewBox="0 0 24 24"
                      aria-hidden="true"
                    >
                      <path
                        d="M22 4c0-1.1-.9-2-2-2H4c-1.1 0-2 .9-2 2v12c0 1.1.9 2 2 2h14l4 4V4z"
                      ></path></svg
                    >{{ solution.feedbacks.length }}</span
                  >
                </p>
              </div>
            </div>
          </div>
        </div>
        <div class="overview col-lg-3">
          <div class="overview-content">
            <div class="overview-title">
              <h4>Thành tích</h4>
            </div>
            <div class="reputations">
              <span class="reputations-value">0 </span>
              <span class="reputations-text">Chứng chỉ</span>
            </div>
            <div class="overview-row">
              <div class="overview-key">Thích</div>
              <div class="overview-value" v-if="data.upvotes">
                {{ data.upvotes.length }}
              </div>
            </div>
            <div class="overview-row">
              <div class="overview-key">Giải pháp</div>
              <div class="overview-value" v-if="data.solutions">
                {{ data.solutions.length }}
              </div>
            </div>
          </div>
        </div>
        <div class="latest-tutorials col-lg-4">
          <div class="lastest-tutorial-content">
            <div class="tutorial-title">
              <h4>Hướng dẫn mới nhất</h4>
            </div>
            <a href="https://www.youtube.com/watch?v=QX_tvDZNB8Y&list=PLSo2LcvIId74yRg1IbUP0YlbwdIaslPL1" target="_blank">
              <div class="tutorial-row">
                <div class="tutorial-title">Xây dựng API bằng NodeJS</div>
                <div class="tutorial-image">
                  <img src="images/item.PNG" alt="" />
                </div>
              </div>
            </a>
            <a href="https://www.youtube.com/watch?v=3ujr0Epj-XU&list=PLSo2LcvIId74ZOYQwIyhRA1AXBt2jy-r8" target="_blank">
              <div class="tutorial-row">
                <div class="tutorial-title">React cơ bản</div>
                <div class="tutorial-image">
                  <img src="images/item.PNG" alt="" />
                </div>
              </div>
            </a>
            <a href="https://www.youtube.com/watch?v=enAtLVRUOik&list=PLSo2LcvIId75IPf7BA_HuUTi1AhtMRo6J" target="_blank">
              <div class="tutorial-row">
                <div class="tutorial-title">CSS Grid</div>
                <div class="tutorial-image">
                  <img src="images/item.PNG" alt="" />
                </div>
              </div>
            </a>
            <a href="https://www.youtube.com/watch?v=eL6jY3WbtIA&list=PLSo2LcvIId75cjfNIP8vAMAW62r279yV_" target="_blank">
              <div class="tutorial-row">
                <div class="tutorial-title">Cắt giao diện HTML/CSS</div>
                <div class="tutorial-image">
                  <img src="images/item.PNG" alt="" />
                </div>
              </div>
            </a>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>
<script>
export default {
  data() {
    return {
      data: {},
    };
  },
  created() {
    this.getData();
  },
  methods: {
    getData() {
      axios
        .get(route("challengeUser.solution"))
        .then((response) => {
          var result = response.data.data;
          this.data = result;
        })
        // eslint-disable-next-line
        .catch((errors) => {
          //Handle Errors
        });
    },
  },
};
</script>

<style lang="scss">
@import "../../../sass/dashboard.scss";
</style>