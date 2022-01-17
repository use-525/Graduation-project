<template>
   <div>
      <span v-for="role in data[name]" :key="role.id">
          <span>{{ role.name }}</span>
      </span>
   </div>
</template>
<script>
export default {
    props: {
        data: {},
        name: {}
    },
}
</script>