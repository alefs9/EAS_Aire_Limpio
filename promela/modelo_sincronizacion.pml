#define NUM_WORKERS 4

int cambiosTotales = 0;
bool mutex = false;

/*
 * Cada Worker representa una goroutine del programa en Go.
 */
proctype Worker(int id) {
    int cambiosLocal;

    /*
     * Cada worker puede encontrar una cantidad diferente
     * de cambios en los datos que procesa.
     */
    if
    :: cambiosLocal = 0
    :: cambiosLocal = 1
    :: cambiosLocal = 2
    fi;

    printf("Worker %d inicio\n", id);

    /*
     * Equivale al mu.Lock() de Go.
     *
     * El worker espera hasta que el mutex este libre.
     */
    atomic {
        !mutex -> mutex = true;
    }

    /*
     * Esta es la parte que queremos proteger.
     *
     * En Go:
     *     cambiosTotales += cambiosLocal
     */
    cambiosTotales = cambiosTotales + cambiosLocal;

    /*
     * Equivale al mu.Unlock() de Go.
     */
    atomic {
        mutex = false;
    }

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