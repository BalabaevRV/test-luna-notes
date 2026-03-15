<template>
    <div class="input-wrap">
        <label class="input-name" for="noteName">Название заметки</label>
        <input id="noteName" v-model="text" :class="['input', {'input-error': error}]" type="text" placeholder="Название" @click="$emit('clearError')">
        <p v-if="error" class="input-error-text">{{ error }}</p>
    </div>
</template>

<script lang="ts" setup>
    defineEmits(['clearError'])

    const text = defineModel<string>();

    defineProps({error: {
        type: String,
        default: ''
    }})
</script>


<style lang="scss" scoped>
    .input {
        padding: 8px;
        border-radius: 6px;
        border-color: $color-primary;
        transition: $transition-border;
        &-wrap {
            display: flex;
            flex-direction: column;
            margin-bottom: 32px;
        }
        &-name {
            @include font-14-semibold;
            margin-bottom: 4px;
        }
        &-error {
            border-color: $color-error;
            &-text {
                color: $color-error;
            }
        }
    }
</style>