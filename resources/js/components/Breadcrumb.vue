<template>
  
    <div :class="classes">
      <h1 class="page-title">{{title}}</h1>
        <ol class="breadcrumb">
            <li class="breadcrumb-item">
                <router-link :to="{name: 'dashboard'}">Home</router-link>
                <!-- <a href="index.html"><i class="la la-home font-20"></i></a> -->
            </li>
            <li class="breadcrumb-item">{{title}}</li>
        </ol>
    </div>
</template>

<script>

export default {
  name: 'breadcrumb',
   props: {
    title: { type: String, default: null },
    classes:{type: String, default: null}
  }
}
</script>
