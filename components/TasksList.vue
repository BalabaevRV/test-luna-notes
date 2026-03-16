<template>
        <div class="tasks-wrap">
            <p class="tasks-title">Задачи:</p>
            <ul ref="listWrap" class="tasks-list-wrap">
                <li v-for="task in tasks" :key="task.id" class="tasks-item-wrap">
                    <div :class="['tasks-item', {'tasks-item-error': task.error}]">
                        <input :id="`task-${task.id}`" v-model="task.name"  class="tasks-item-input" type="text" placeholder="Задача" :disabled="task.finished" @focus="task.error = ''">
                        <ui-checkbox :id="task.id" v-model="task.finished" :disabled="!task.name" @click-checkbox="taskChecboxHandler(task)" />
                    </div>
                    <p v-if="task.error" class="tasks-item-error-text"> {{ task.error }}</p>
                </li>
            </ul>
            <ui-btn @click="addTask" >Добавить задачу</ui-btn>
        </div>
</template>

<script lang="ts" setup>
import type { Task } from '@/types';
const notesStore = useNotesStore()
const listWrap = ref<HTMLElement | null>(null)

const tasks = defineModel<Task[]>();

const addTask = async () => {   
    if (!tasks.value) {
        return
    }
    tasks.value.push({
        id: notesStore.generateId(),
        name: '',
        finished: false
    }) 
}

const taskChecboxHandler = (task: Task) => {
    if (!task.name) {
        task.error = 'Укажите имя задачи'
    }
}

</script>

<style lang="scss" scoped>
    .tasks {
        &-wrap {
            margin-bottom: 24px;
            border-radius: 14px;
            background-color: $color-secondary;
            padding: 24px;
        }
        &-title {   
            margin-bottom: 8px;
            @include font-16-medium;
        }
        &-list-wrap {
            margin: 0;
            margin-bottom: 16px;
            overflow-x: hidden;
            overflow-y: auto;
            max-height: 168px;
            padding-right: 8px;
        }
        &-item {
            list-style: none;
            padding: 0;
            border-bottom: 1px solid $color-text;
            display: flex;
            justify-content: space-between;
            padding-bottom: 4px;
            margin-bottom: 4px;
            position: relative;
            &-error {
                border-bottom: 1px solid $color-error;
            }
            &-error-text {
                color: $color-error;
                @include font-14-normal;
                margin: 0;
            }
            &-wrap {
                margin-bottom: 8px;
            }
            &::after {
                content: '';
                width: 0;
                background-color: $color-primary;
                position: absolute;
                height: 1px;
                top: 10px;
            }
            &-input {
                background: none;
                border: none;
                flex-grow: 1;
                margin-right: 8px;
                &::after {
                    content: '';
                    width: 100%;
                    background-color: red;
                    position: absolute;
                    height: 2px;
                    top: 10px;
                }
                &:focus {
                    outline: none;
                }
            }
        }
    }
 
    .tasks-item:has(input:checked) {
        &::after {
            width: calc(100% - 28px);
        }
    }
</style>