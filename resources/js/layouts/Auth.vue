<template>
  <div class="login-wrapper">
    <div class="auth-form">
          <router-view />
    </div>
  </div>
</template>

<script>
export default {
  name: "AuthLayout",
};
</script>
<style  scoped>
@import "../../sass/auth.css";
</style>