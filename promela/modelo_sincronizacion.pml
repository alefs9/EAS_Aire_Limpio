#define NUM_WORKERS 4

int cambiosTotales = 0;
bool mutex = false;
int workersTerminados = 0;

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
     */
    atomic {
        !mutex -> mutex = true;
    }

    /*
     * Actualizamos el total de cambios.
     */
    cambiosTotales = cambiosTotales + cambiosLocal;

    /*
     * Equivale al mu.Unlock() de Go.
     */
    atomic {
        mutex = false;
    }

    /*
     * Equivale al wg.Done() de Go.
     *
     * Indicamos que este worker ya termino.
     */
    atomic {
        workersTerminados++
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

    /*
     * Equivale al wg.Wait() de Go.
     *
     * Esperamos hasta que todos los workers terminen.
     */
    workersTerminados == NUM_WORKERS;

    printf("Todos los workers terminaron\n");
}