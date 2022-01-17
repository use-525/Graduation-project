<template>
  <div class="content col-12">
    <div class="container">
      <div class="overview row">
        <div class="description col-xl-8 col-lg-6">
          <div class="container-content" v-if="data.category">
            <div class="desc-time" v-if="data.category.time">
              Cập nhật mới nhất: {{ data.category.time }}
            </div>
            <div class="desc-title">
              <h1>{{ data.category.name }}</h1>
            </div>
            <div class="short-desc" v-html="data.category.description"></div>

            <div id="desc-box" class="desc-box2">
              <div class="box-title">
                <h5>Quy tắc:</h5>
              </div>
              <div v-html="data.category.rule"></div>
            </div>
          </div>
        </div>
        <div class="require col-xl-4 col-lg-6" v-if="data.challenges">
          <div class="container-content">
            <div class="require-image">
              <img
                v-if="data.category"
                :src="'/' + data.category.image"
                alt="error"
              />
            </div>
            <div class="require-title">
              <h5>Yêu cầu chứng chỉ</h5>
            </div>
            <ul class="list-require">
              <li>Đã hoàn thành {{ data.challenges.length }} thử thách</li>
            </ul>
            <div class="progres">
              <h5>Progress</h5>
              <p>
                {{ data.number_solution }} /
                {{ data.challenges.length }} completed
              </p>
              <div class="progres-level">
                <div
                  v-for="n in data.challenges.length"
                  :key="n"
                  :style="
                    n < data.number_solution + 1
                      ? 'background-color:#6d2fff;'
                      : 'background-color:#e5eaf0;'
                  "
                  class="progres-level-item"
                ></div>
              </div>
            </div>

            <div class="apply-button">
              <button>ĐĂNG KÝ CHỨNG CHỈ</button>
            </div>
          </div>
        </div>
      </div>
      <div v-if="data" class="product">
        <div class="product-title">
          <h2>Các sản phẩm bạn sẽ phải làm</h2>
          <div class="list-product row">
            <div
              v-for="challenge in data.challenges"
              :key="challenge.id"
              class="product-item col-xl-4 col-md-6"
            >
              <div class="" v-if="challenge.level <= 3">
                <router-link
                  :to="{ name: 'chanllenge', params: { slug: challenge.slug } }"
                >
                  <div class="product-content">
                    <div class="product-image">
                      <img :src="'/' + challenge.image" alt="" />
                    </div>
                    <div class="product-content-title">
                      {{ challenge.title }}
                    </div>
                    <div
                      v-html="challenge.description.substring(0, 150) + ' ...'"
                      class="product-desc"
                    ></div>
                    <div class="product-level">
                      <div class="product-level-name">
                        <p v-if="challenge.level == 1">Beginner</p>
                        <p v-else-if="challenge.level == 2">Elementary</p>
                        <p v-else-if="challenge.level == 3">Intermediate</p>
                        <p v-else-if="challenge.level == 4">
                          Upper intermediate
                        </p>
                        <p v-else-if="challenge.level == 5">Advanced</p>
                        <p v-else>Proficient</p>
                      </div>
                      <div class="product-level-main">
                        <span></span>
                        <div
                          v-for="n in 6"
                          :key="n"
                          :style="
                            n < challenge.level + 1
                              ? 'background-color:#6d2fff;'
                              : 'background-color:#e5eaf0;'
                          "
                          class="product-level-item"
                        ></div>
                      </div>
                    </div>
                  </div>
                </router-link>
              </div>

              <div
                v-if="challenge.level == 4 || challenge.level == 5"
                v-on:click="checkLevelUser(challenge.slug, 'vip1')"
              >
                <div class="product-content">
                  <img
                    v-if="
                      $can('user vip2') != true && $can('user vip1') != true
                    "
                    src="/images/lock-512 (1).png"
                    class="lock-level"
                    alt=""
                  />
                  <div class="product-image">
                    <img :src="'/' + challenge.image" alt="" />
                  </div>
                  <div class="product-content-title">
                    {{ challenge.title }}
                  </div>
                  <div
                    v-html="challenge.description.substring(0, 150) + ' ...'"
                    class="product-desc"
                  ></div>
                  <div class="product-level">
                    <div class="product-level-name">
                      <p v-if="challenge.level == 1">Beginner</p>
                      <p v-else-if="challenge.level == 2">Elementary</p>
                      <p v-else-if="challenge.level == 3">Intermediate</p>
                      <p v-else-if="challenge.level == 4">Upper intermediate</p>
                      <p v-else-if="challenge.level == 5">Advanced</p>
                      <p v-else>Proficient</p>
                    </div>
                    <div class="product-level-main">
                      <span></span>
                      <div
                        v-for="n in 6"
                        :key="n"
                        :style="
                          n < challenge.level + 1
                            ? 'background-color:#6d2fff;'
                            : 'background-color:#e5eaf0;'
                        "
                        class="product-level-item"
                      ></div>
                    </div>
                  </div>
                </div>
              </div>

              <div
                v-if="challenge.level == 6"
                v-on:click="checkLevelUser(challenge.slug, 'vip3')"
              >
                <div class="product-content">
                  <img
                    v-if="$can('user vip3') != true"
                    src="/images/lock-512.png"
                    class="lock-level"
                    alt=""
                  />
                  <div class="product-image">
                    <img :src="'/' + challenge.image" alt="" />
                  </div>
                  <div class="product-content-title">
                    {{ challenge.title }}
                  </div>
                  <div
                    v-html="challenge.description.substring(0, 150) + ' ...'"
                    class="product-desc"
                  ></div>
                  <div class="product-level">
                    <div class="product-level-name">
                      <p v-if="challenge.level == 1">Beginner</p>
                      <p v-else-if="challenge.level == 2">Elementary</p>
                      <p v-else-if="challenge.level == 3">Intermediate</p>
                      <p v-else-if="challenge.level == 4">Upper intermediate</p>
                      <p v-else-if="challenge.level == 5">Advanced</p>
                      <p v-else>Proficient</p>
                    </div>
                    <div class="product-level-main">
                      <span></span>
                      <div
                        v-for="n in 6"
                        :key="n"
                        :style="
                          n < challenge.level + 1
                            ? 'background-color:#6d2fff;'
                            : 'background-color:#e5eaf0;'
                        "
                        class="product-level-item"
                      ></div>
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>


<script>
import { mapGetters } from "vuex";
export default {
  data: () => ({
    title: "Chi Tiet Danh Muc Thu Thach",
  }),
  computed: mapGetters({
    data: "challenge/challenge",
  }),
  created() {
    this.$store.dispatch("challenge/fetchByCate", this.$route.params.slug);
    this.$store.dispatch(
      "challengecategory/get_One_Data",
      this.$route.params.slug
    );
  },
  methods: {
    checkLevelUser(slug, upgrade) {
      if (this.$can("user vip1") != true) {
        this.showAlert();
      } else if (this.$can("user vip3") != true) {
        this.showAlert();
      } else {
        this.$router.push({ name: "chanllenge", params: { slug: slug } });
      }
    },
    showAlert() {
      Swal.fire({
        icon: "warning",
        title: "Nâng Cấp Tài Khoản",
        text: "Bạn cần nâng cấp tài khoản để làm bài tập này",
        showCloseButton: true,
        showCancelButton: true,
        focusConfirm: false,
        confirmButtonText: '<i class="fa fa-thumbs-up"></i> Nâng cấp!',
        cancelButtonText: "Bỏ qua",
      }).then((result) => {
        /* Read more about isConfirmed, isDenied below */
        if (result.isConfirmed) {
          this.$router.push({ name: "premium" });
        } else if (result.isDenied) {
        }
      });
    },
  },
};
</script>

<style lang="scss">
@import "../../../sass/overview.scss";
</style>
