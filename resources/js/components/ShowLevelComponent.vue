<template>
   <div>
        <span v-if="data.level==1">Beginner</span>
        <span v-else-if="data.level==2">Elementary</span>
        <span v-else-if="data.level==3">Intermediate</span>
        <span v-else-if="data.level==4">Upper intermediate</span>
        <span v-else-if="data.level==5">Advanced</span>
        <span v-else>Proficient</span>
   </div>
</template>
<script>
export default {
    props: {
        data: {},
    },
}
</script>