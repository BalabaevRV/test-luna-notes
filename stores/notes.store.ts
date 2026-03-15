import type { Note } from "@/types"

export const useNotesStore = defineStore('notes', () => {
    const notesList = ref<Note[]>([])
    const addNote = (note: Note) => {
        notesList.value.push({
            ...note,
            id: generateId()
        })
    }

    const updateNote = (id: string, updatedNote: Note) => {
        const index = notesList.value.findIndex(el => el.id === id)
        if (index !== -1) {
            notesList.value[index] = { ...updatedNote }
        }
    }

    const deleteNote = (id: string) => {
         notesList.value = notesList.value.filter(note => note.id !== id)
    }

    const generateId = () => {
        return `${Date.now()}_${Math.random().toString(36)}`
    }

    return { notesList, addNote, updateNote, deleteNote, generateId }
}, {  persist: true })