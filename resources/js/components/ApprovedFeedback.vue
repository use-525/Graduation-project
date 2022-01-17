<template>
   <div>
        <button v-if="data.is_approved == 1" type="button" class="btn btn-success"><i class="ti-check"></i> Đã duyệt</button>
        <button v-else type="button" @click="click(data.id)" class="btn btn-warning"><i class="ti-close"></i> Chưa duyệt</button>
   </div>
</template>
<script>
export default {
    props: {
        data: {},
        name: '',
        click: {},
        meta: {},
        classes: {},
    },
}
</script>