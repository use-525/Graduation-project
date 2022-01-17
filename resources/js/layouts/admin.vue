<template>
  <div class="page-wrapper">
      <navbar :user=user></navbar>
      <sidebar :user=user></sidebar>
      <slot />
        
  </div>
</template>

<script>
import { mapGetters } from 'vuex'
import Navbar from '../components/Navbar.vue'
import Sidebar from '../components/Sidebar.vue'
export default {
  name: 'AdminLayout',
  computed: mapGetters({
    user: 'auth/user'
  }),
  
  created () {
    this.$store.dispatch('auth/fetchUser');
  },
   
  components: {
    Navbar,
    Sidebar
  }
}

</script>
