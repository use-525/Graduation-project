<template>
  <div class="app">
     <div class="home-wapper">
        <SidebarMain></SidebarMain>
      <main>
        <HeaderMain></HeaderMain>
        <slot />
        <Social></Social>
        <Footer></Footer>
      </main>
     </div>
  </div>
</template>

<script>

import SidebarMain from '../components/site/SidebarMain.vue'
import HeaderMain from '../components/site/HeaderMain.vue'
import Footer from '../components/site/Footer.vue'
import Social from '../components/site/Social.vue'

export default {
  name: 'MainLayout',

  components: {
    SidebarMain,
    HeaderMain,
    Footer,
    Social
  }
}
</script>
<style lang="scss">
// @import "../../sass/overview.scss";
</style>