<template>
    <button :class="[`btn btn-${type}`, {'btn--disabled' : disabled}]" :disabled="disabled">
         <slot />
    </button>
</template>

<script setup lang="ts">

withDefaults(defineProps<{
    type?: 'primary' | 'secondary' | 'link',
    disabled?: boolean
}>(), {
    type: 'primary',
    disabled: false
})

</script>

<style lang="scss" scoped>
    .btn {
        padding: 12px;
        border-radius: 8px;
        border: none;
        cursor: pointer;
        @include font-14-semibold;
        &-primary {
            background-color: $color-primary;
            color: $color-white;
            transition: $transition-bg;
            &:not(.btn--disabled):hover {
              background-color: $color-primary--hover;  
            }
            &:not(.btn--disabled):active {
              background-color: $color-primary--active;  
            }
        }
        &-secondary {
            background: none;
            border: 2px solid $color-primary;
            color: $color-primary;
            transition: $transition-color, $transition-border;
            &:not(.btn--disabled):hover {
                border-color: $color-primary--hover;
                color: $color-primary--hover;  
            }
            &:not(.btn--disabled):active {
              border-color: $color-primary--active;  
              color: $color-primary--active;  
            }    
        }
        &-link {
            background: none;
            border-radius: 0;
            border-bottom: 2px solid $color-primary;
            padding: 0;
            line-height: 100%;
            color: $color-primary;
            transition: $transition-color, $transition-border;    
            &:not(.btn--disabled):hover {
                border-color: $color-primary--hover;
                color: $color-primary--hover;  
            }
            &:not(.btn--disabled):active {
              border-color: $color-primary--active;  
              color: $color-primary--active;  
            }            
        }
        &--disabled {
            cursor: default;
            opacity: .5;
        }
    }
</style>