<template>
<div>
     <input type="checkbox" class="checkbox-table ml-1" :value="data.id" name="selected[]">
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