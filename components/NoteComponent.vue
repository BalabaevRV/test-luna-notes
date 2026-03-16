<template>
    <div>
        <p class="title">{{ title }}</p>
        <ui-input v-model="currentNote.name" :error="error" @clear-error="error = ''" />
        <tasks-list ref="tasksListRef" v-model="currentNote.tasks" @add-task="handleAddTask"/>
        <div class="note-controllers">
            <ui-btn type="secondary" :class="['btn-action-controll']" :disabled="!canUndo" @click="undo" ><ui-svg-icon name='undo' :size="24"/></ui-btn>
            <ui-btn type="secondary" :class="['btn-action-controll']" :disabled="!canRedo" @click="redo"><ui-svg-icon name='redo' :size="24"/></ui-btn>
        </div>
        <div class="note-controllers note-controllers--buttons">
            <ui-btn @click="saveNote">Сохранить изменения</ui-btn>
            <ui-btn type="secondary" @click="cancelEditDialog = true">{{ id ? 'Отменить редактирование' : 'Вернуться на главную' }}</ui-btn>
            <ui-btn v-if="id" type="link" @click="deleteConfirmationDialog = true">Удалить</ui-btn>
        </div>
        <dialog-component v-if="deleteConfirmationDialog" :title="`Вы действительно хотите удалить заметку «${currentNote.name}»?`" second-btn-text="Нет" @close="closeDeleteConfirmationDialog" @click-first-btn="deleteNote" @click-second-btn="closeDeleteConfirmationDialog" />
        <dialog-component v-if="cancelEditDialog" :title="id ? `Вы действительно хотите отменить редактирование заметки «${currentNote.name}»?` : `Вы действительно хотите отменить создание заметки?`" second-btn-text="Нет" @close="closeCancelEditDialog" @click-first-btn="cancelEdit" @click-second-btn="closeCancelEditDialog" />
    </div>
</template>

<script lang="ts" setup>
    import type { Note } from '@/types'
    import { useRefHistory } from '@vueuse/core'

    const route = useRoute()


    const cancelEditDialog = ref(false)
    const deleteConfirmationDialog = ref(false)
    const notesStore = useNotesStore()
    const currentNote = ref<Note>({
            id: '',
            name: '',
            tasks: []
        })

    const { canUndo, canRedo, undo, redo, batch, clear } = useRefHistory(currentNote, {
    deep: true,
    capacity: 50
    });
    const error = ref('')
    const id = computed(() => route.params.id)
    const title = computed(() => id.value ? 'Редактирование заметки' : 'Новая заметка')


    const closeDeleteConfirmationDialog = () => deleteConfirmationDialog.value = false
    const closeCancelEditDialog = () => cancelEditDialog.value = false

    const deleteNote = () => {
        notesStore.deleteNote(String(id.value))
        navigateTo(`/`)
    }


    const cancelEdit = () => {
        navigateTo(`/`)
    }

    const checkAllTasksHaveName = ():boolean => {
        let allTasksHaveName = true
        currentNote.value.tasks.forEach(task => {
            if (!task.name) {
                task.error = 'Укажите имя задачи'
                allTasksHaveName = false
            }
        });
        return allTasksHaveName
    }

    const saveNote = () => {

        if (!checkAllTasksHaveName()) {
            return;
        }
         if (!currentNote.value.name) {
            error.value = 'Укажите название заметки';
            return;
        }

        if (id.value) {
            notesStore.updateNote(String(id.value), currentNote.value)
        } else {
            notesStore.addNote(currentNote.value)
        }
            navigateTo(`/`)
    }

    const handleAddTask = () => {
        batch(() => {
            currentNote.value.tasks.push({
                id: notesStore.generateId(),
                name: '',
                finished: false
            })
        }) 
    }

    onMounted(async () => {
        if (id.value) {
            const findedNote = notesStore.notesList.find(el => el.id === id.value)
            if (findedNote) {
                currentNote.value = findedNote    
                await nextTick(() => {
                clear()
                })  
            }
        }
    })

</script>

<style lang="scss" scoped>
    .note {
        &-title {
            @include font-20-bold;
            margin-bottom: 32px;
        }
    }

    .note-controllers {
        margin-bottom: 24px;
        display: flex;
        align-items: center;
        gap: 16px;
        &--buttons {
            @media (max-width: $min-screen) {
                flex-direction: column;
                align-items: stretch;
            & .btn-link:last-child {
                align-self: center; 
            }
            }
        }
    }

    .btn-action-controll {
        padding: 4px 18px 2px;
    }

</style>