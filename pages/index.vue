<template>
    <div>
        <h1 class="title">Мои заметки</h1>
        <div v-if="notesList.length" class="notes-wrap">
            <note-card v-for="note in notesList" :key="note.id" :note="note" />
        </div>
        <p v-else class="notes-placeholder">Заметок ещё нет. Создайте первую заметку</p>
        <ui-btn @click="navigateTo(`/note`)">Создать заметку</ui-btn>
    </div>
</template>

<script setup lang="ts">
    const notesStore = useNotesStore()
    const { notesList } = storeToRefs(notesStore)
</script>

<style lang="scss" scoped>
    .notes {
        &-wrap {
            display: grid;
            grid-template-columns: repeat(3, minmax(0, 1fr)); 
            flex-wrap: wrap;
            gap: 24px;
            margin-bottom: 24px;
            width: 100%;
            @media (max-width: $middle-screen) {
                grid-template-columns: repeat(2, minmax(0, 1fr)); 
            }
            @media (max-width: $min-screen) {
                grid-template-columns: repeat(1, minmax(0, 1fr)); 
            }
        }
        &-placeholder {
            @include font-16-medium;
            margin-bottom: 24px;
        }
    }
</style>