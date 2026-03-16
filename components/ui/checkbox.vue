<template>
    <div>
        <input :id="`taskCheckbox-${id}`" v-model="check" class="checkbox-input" type="checkbox" :disabled="disabled">
        <label class="checkbox-label" :for="`taskCheckbox-${id}`" @click="$emit('clickCheckbox')" />
    </div>
</template>

<script lang="ts" setup>
    defineEmits(['clickCheckbox'])

    const check = defineModel<boolean>();

    defineProps<{
        id: string,
        disabled: boolean
    }>()

</script>

<style lang="scss" scoped>
   .checkbox {
        &-input {
            position: absolute;
            z-index: -1;
            opacity: 0;
        }
        &-label {
            position: relative;
            height: 24px;
            cursor: pointer;
            &:before {
                content: "";
                display: inline-block;
                width: 16px;
                height: 16px;
                background-color: $color-white;
                border-radius: 4px;
            }
            &:after {
                content: "";
                display: block;
                position: absolute;
                height: 8px;
                width: 5px;
                border: 2px solid rgba(0, 0, 0, 0);
                border-left: 0;
                border-bottom: 0;
                top: 6px;
                left: 3px;
                -webkit-transform-origin: left top;
                -ms-transform-origin: left top;
                transform-origin: left top;
                -webkit-transform: scaleX(-1) rotate(135deg);
                -ms-transform: scaleX(-1) rotate(135deg);
                transform: scaleX(-1) rotate(135deg);
            }
        }
    }

@keyframes check {
    0% {
        height: 0;
        width: 0;
    }
    100% {
        height: 8px;
        width: 5px;
    }
}

.checkbox-input:checked+.checkbox-label::after {
	border-color: $color-primary;
    -webkit-animation: check 0.25s;
    animation: check 0.25s;
}
</style>