#define NUM_WORKERS 4

/*
 * Cada Worker representa una goroutine del programa en Go.
 */
proctype Worker(int id) {

    printf("Worker %d inicio\n", id);

    /*
     * Por ahora no hacemos ninguna operacion.
     * Solo queremos comprobar que podemos crear
     * varios workers al mismo tiempo.
     */

    printf("Worker %d termino\n", id);
}

/*
 * Main crea los 4 workers.
 */
init {
    int i = 0;

    do
    :: i < NUM_WORKERS ->
        run Worker(i);
        i++

    :: else ->
        break
    od;
}