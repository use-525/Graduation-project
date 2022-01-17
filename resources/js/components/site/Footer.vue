<template>
  <footer>
    <div class="container">
      <div class="row">
        <div class="col-md-6 mb-4 pb-4">
          <div class="logo-ft">
            <img src="/images/logo-ft.png" width="150" />
          </div>

          <p class="ft-description">
            Tài nguyên và Cộng đồng Phát triển Web giúp bạn trở thành Nhà phát
            triển Web bằng cách làm việc với các dự án thực tiễn trong thực
            tế.<br />
            <span
              >Dự án được phát triển bởi nhóm dự án tốt nghiệp
              <a class="develope-name" href="/">FPT POLYTECHNIC</a></span
            >
          </p>
          <p>© 2021 devfpoly.io</p>
        </div>
        <div class="col-md-3 footer-cate mb-4 pb-4">
          <router-link :to="{ name: 'privacy' }">Chính sách bảo mật</router-link>
          <router-link :to="{ name: 'privacy' }">Điểu khoản sử dụng</router-link>
          <router-link :to="{ name: 'faq' }">FAQ</router-link>
        </div>
        <div class="col-md-3 footer-cate mb-4 pb-4">
           <router-link :to="{ name: 'home' }">Trang chủ</router-link>
          <a href="https://www.youtube.com/channel/UCr3kDr9QiZ7VbZxAKh57OFQ" target="_blank">Học tập</a>
        </div>
      </div>
    </div>
  </footer>
</template>

<script>
export default {};
</script>

<style></style>
