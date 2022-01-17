<template>
  <div class="app">
     <div class="home-wapper">
        <SidebarHome></SidebarHome>
      <main>
        <Header></Header>
        <slot />
        <Social></Social>
        <Footer></Footer>
      </main>
     </div>
  </div>
</template>

<script>
import SidebarHome from '../components/site/SidebarHome.vue'
import Header from '../components/site/Header.vue'
import Footer from '../components/site/Footer.vue'
import Social from '../components/site/Social.vue'

export default {
  name: 'HomeLayout',

  components: {
    SidebarHome,
    Header,
    Footer,
    Social
  }
}
</script>
<style lang="scss" scoped>
// @import "../../sass/home.scss";
</style>
