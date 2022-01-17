<template>
   <div>
       <a :href="data.demo_url" v-if="name=='demo_url'" target="_blank"><i class="ti-link"></i> Xem demo</a>
       <a :href="data.link_github" v-else target="_blank"><i class="ti-link"></i> Xem source</a>
   </div>
</template>
<script>
export default {
    props: {
        data: {},
        name:''
    },
}
</script>