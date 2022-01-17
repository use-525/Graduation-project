<template>
   <div>
        <span v-if="name=='add.feedback'">
            <router-link v-if="data.parent_id==0" :to="{name: name, params: { parent_id: data.id,solution_id:data.solution_id }}" class="btn btn-info">Trả lời
            </router-link>
            <router-link v-else :to="{name: name, params: { parent_id: data.parent_id,solution_id:data.solution_id }}" class="btn btn-info">Trả lời
            </router-link>
        </span>
        <router-link v-else :to="{name: name, params: { id: data.id }}" class="btn btn-info">Sửa
        </router-link>
        <button
        type="button"
        @click="click(data.id)"
        class="btn btn-danger"
       >
        Xoá
    </button>
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