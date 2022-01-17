<template>
<div>
    <img v-if="data.image" :src="'/'+data.image" alt="" :class="classes">
    <img v-else :src="data.photo_url" alt="" :class="classes">
</div>
</template>
<script>
export default {
    props: {
        data: {},
        classes: {},
    },
}
</script>