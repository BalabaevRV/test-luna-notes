export type Task = {
    name: string,
    id: string,
    finished: boolean,
    error?: string
}

export type Note = {
    name: string,
    id: string,
    tasks: Task[]
}
