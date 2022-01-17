<template>
  <section class="content">
    <div class="container">
      <div class="step-list mb-3">
        <div class="row">
          <div class="col-md-12 mb-4">
            <h1 class="welcome">CHÀO MỪNG BẠN ĐẾN VỚI DEVPOLY</h1>
          </div>
        </div>

        <div class="row content-list">
          <div class="col-md-6 col-xs-12 col-lg-6 col-xl-4">
            <div class="content-item">
              <div class="content-item-image">
                <img src="svg/Step1.svg" alt="" />
              </div>
              <div class="content-item-title mb-3">
                <h3 class="text-primary">Bước 1: Chọn thử thách</h3>
              </div>
              <div class="content-item-des">
                <p>
                  Chọn một trong các thử thách bên dưới, đọc kỹ mô tả, bạn sẽ
                  được hướng dẫn và nhận được chứng chỉ sau khi hoàn thành thử
                  thách.
                </p>
              </div>
            </div>
          </div>

          <div class="col-md-6 col-xs-12 col-lg-6 col-xl-4">
            <div class="content-item">
              <div class="content-item-image">
                <img src="svg/Step2.svg" alt="" />
              </div>
              <div class="content-item-title mb-3">
                <h3 class="text-primary">
                  Bước 2: Làm thử thách một mình hoặc cùng team
                </h3>
              </div>
              <div class="content-item-des">
                <p>
                  Tất cả các thử thách có thể được hoàn thành bởi một người,
                  nhưng tinh thần đồng đội là rất quan trọng tại nơi làm việc.
                  Nếu thử thách quá lớn đối với bạn, hãy rủ một người bạn cùng
                  tham gia.
                </p>
              </div>
            </div>
          </div>

          <div class="col-md-6 col-xs-12 col-lg-6 col-xl-4">
            <div class="content-item">
              <div class="content-item-image">
                <img src="svg/Step3.svg" alt="" />
              </div>
              <div class="content-item-title mb-3">
                <h3 class="text-primary">
                  Bước 3: Gửi các giải pháp và đánh giá
                </h3>
              </div>
              <div class="content-item-des">
                <p>
                  Khi bạn hoàn thành thử thách, hãy gửi giải pháp của bạn. Bạn
                  cũng có thể kiểm tra xem đã có giải pháp nào chưa và cung cấp
                  cho họ một số phản hồi.
                </p>
              </div>
            </div>
          </div>
        </div>
      </div>

      <div class="challenge-path">
        <div class="row">
          <div class="col-md-12 mb-3">
            <h1 class="path">Danh mục</h1>
          </div>
        </div>

        <div class="row content-list">
          <div
            v-for="challengecategory in challengecategories"
            :key="challengecategory.id"
            class="col-md-6 col-xs-12 col-lg-6 col-xl-4"
          >
            <router-link
              :to="{
                name: 'overview',
                params: { slug: challengecategory.slug },
              }"
              style="text-decoration: none"
            >
              <div class="content-item">
                <div class="content-item-image img-challenge-path">
                  <img :src="'/' + challengecategory.image" alt="" />
                </div>
                <div class="content-item-title">
                  <h3>{{ challengecategory.name }}</h3>
                </div>
                <div class="content-item-des">
                  <p v-html="challengecategory.description"></p>
                </div>
              </div>
            </router-link>
          </div>
        </div>
      </div>
    </div>
  </section>
</template>
<script>
export default {
  data() {
    return {
      title: "Home",
    };
  },
  computed: {
    challengecategories() {
      return this.$store.state.challengecategory.challengecategories;
    },
  },
  created: function () {
    this.$store.dispatch("challengecategory/get_All_Data");
  },
  methods: {},
};
</script>

<style lang="scss">
@import "../../../sass/home.scss";
</style>
