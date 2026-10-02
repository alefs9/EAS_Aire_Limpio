// Cantidad de workers utilizada en la implementación concurrente en Go.
#define NUM_WORKERS 4

// Se utilizan pocas iteraciones para reducir el espacio de estados analizado por SPIN.
#define MAX_ITER    2   // Pocas iteraciones para facilitar el análisis con SPIN.

// Se utilizan pocas iteraciones para reducir el espacio de estados analizado por SPIN.
#define MAX_ITER 2

// Variables compartidas utilizadas para modelar y verificar la sincronización.
int cambiosTotales    = 0;   // Acumula los cambios realizados por todos los workers.
int sumaControl       = 0;   // Valor de referencia para detectar posibles actualizaciones perdidas.
int workersTerminados = 0;   // Cantidad de workers que finalizaron su ejecución.
bool mutex            = false;  // Representa el mutex utilizado en Go para proteger cambiosTotales.
int enSeccionCritica  = 0;   // Permite comprobar que solo un worker accede a la sección crítica.


/*
 * Cada Worker representa una goroutine del programa en Go.
 *
 * En el programa real, cada worker procesa una parte del dataset.
 */
proctype Worker(int id) {
    int cambiosLocal;

    /*
     * Representamos que cada worker puede encontrar
     * una cantidad diferente de cambios.
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
     * El worker espera hasta que el mutex esté libre.
     */
    atomic {
        !mutex -> mutex = true;
        enSeccionCritica++;

    /*
    * Propiedad de exclusión mutua:
    * nunca debe existir más de un worker dentro
    * de la sección crítica simultáneamente.
    */
        assert(enSeccionCritica == 1);
    }


    /*
     * Sección crítica.
     *
     * En Go:
     *     cambiosTotales += cambiosLocal
     *
     * Solo un worker puede realizar esta operación a la vez.
     */
    cambiosTotales = cambiosTotales + cambiosLocal;


    /*
     * Equivale al mu.Unlock() de Go.
     */
    atomic {
        enSeccionCritica--;
        mutex = false;
    }


    /*
     * Variable de control utilizada para comprobar
     * que no se pierdan actualizaciones.
     */
    atomic {
        sumaControl = sumaControl + cambiosLocal
    }


    /*
     * Equivale al wg.Done() de Go.
     */
    atomic {
        workersTerminados++
    }

    printf("Worker %d termino\n", id);
}


/*
 * Main representa la ejecución principal.
 *
 * Crea los workers y espera a que todos terminen.
 */
active proctype Main() {
    int iter = 0;
    int i;


    do
    :: iter < MAX_ITER ->

        /*
         * Reiniciamos los valores antes de cada iteración.
         */
        cambiosTotales    = 0;
        sumaControl       = 0;
        workersTerminados = 0;


        /*
         * Creamos los 4 workers.
         *
         * Representa la creación de goroutines en Go.
         */
        i = 0;

        do
        :: i < NUM_WORKERS ->
            run Worker(i);
            i++

        :: i >= NUM_WORKERS ->
            break
        od;


        /*
         * Equivale al wg.Wait() de Go.
         *
         * Esperamos hasta que todos los workers terminen.
         */
        workersTerminados == NUM_WORKERS;


        /*
         * Verificamos que no se hayan perdido actualizaciones.
         */
        assert(cambiosTotales == sumaControl);


        /*
         * Si no hubo cambios, se alcanza la convergencia.
         */
        if
        :: cambiosTotales == 0 ->
            printf("Convergencia alcanzada en iter %d\n", iter);
            break

        :: else ->
            /*
             * En Go, aquí se recalculan los centroides.
             * Esa parte es secuencial y no se modela en Promela.
             */
            skip
        fi;

        iter++


    :: iter >= MAX_ITER ->
        break
    od;


    printf("Todos los workers terminaron\n");
    printf("Terminado sin errores de sincronizacion\n");
}


/*
 * Propiedad de terminación:
 * eventualmente los 4 workers deben haber terminado.
 */


/*
 * Propiedades LTL utilizadas para la verificación formal con SPIN.
 *
 * terminacion:
 * Verifica que eventualmente todos los workers finalicen.
 *
 * mutex_liberado:
 * Verifica que, una vez que todos los workers han terminado,
 * el mutex se encuentre liberado.
 */

//ltl terminacion {
//    <> (workersTerminados == NUM_WORKERS)
//}

//ltl mutex_liberado {
//    [] ((workersTerminados == NUM_WORKERS) -> !mutex)
//}