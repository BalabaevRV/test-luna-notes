<template>
    <div class="note">
        <p class="note-name">{{ note.name }}</p>
        <ul class="note-tasks">
            <li v-for="task in firstThreeTasks" :key="task.id" :class="['note-task-name', {'note-task-name--finished': task.finished}]">{{ task.name }}</li>
        </ul>
        <div class="note-controlls">
            <ui-btn @click="navigateTo(`/note/${note.id}`)" >Редактировать</ui-btn>
            <ui-btn type="secondary" @click="deleteConfirmationDialog = true" >Удалить</ui-btn>
        </div>
        <dialog-component v-if="deleteConfirmationDialog" :title="`Вы действительно хотите удалить заметку «${note.name}»?`" second-btn-text="Нет" @close="closeDeleteConfirmationDialog" @click-first-btn="deleteNote" @click-second-btn="closeDeleteConfirmationDialog" />
    </div>  
</template>

<script setup lang="ts">
    import type { Note } from '@/types'
    const notesStore = useNotesStore()

    const { note } = defineProps<{
        note: Note
    }>()

    const firstThreeTasks = computed(() => [...note.tasks].slice(0, 3))

    const deleteConfirmationDialog = ref(false)

    const closeDeleteConfirmationDialog = () => deleteConfirmationDialog.value = false
    const deleteNote = () => notesStore.deleteNote(note.id)

</script>

<style lang="scss" scoped>
    .note {
        background-color: $color-secondary;
        padding: 24px;
        border-radius: 14px;
        display: flex;
        flex-direction: column;
        justify-content: space-between;
        &-name {
            @include font-18-semibold;
        }
        &-tasks {
            margin: 0;
            margin-bottom: 16px;

        }
        &-controlls {
            display: flex;
            flex-wrap: wrap;
            gap: 8px;
            & .btn {
                flex-grow: 1;
            }
        }
        &-task-name {
            list-style: none;
            white-space: nowrap;
            overflow: hidden; 
            text-overflow: ellipsis;
            &:before {
            content: "•"; 
            display: inline-block;
            margin-right: 2px;
            } 
            &--finished {
                text-decoration: line-through;
            }
        }
    }
</style>