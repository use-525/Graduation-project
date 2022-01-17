<template>
  <div class="wrapper" id="app">
      <component :is="layout">
          <router-view/>
      </component>
  </div>
</template>

<script>
const default_layout = 'home';
    export default {
        name: 'App',
       computed:{
           layout(){
               return (this.$route.meta.layout || default_layout)+ '-layout';
           }
       }
    };
</script>