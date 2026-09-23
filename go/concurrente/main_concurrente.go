package main

import (
	"encoding/csv"
	"fmt"
	"math"
	"math/rand"
	"os"
	"strconv"
	"sync"
	"time"
)

// Observacion representa una fila del dataset con sus 5 contaminantes.
type Observacion struct {
	Features []float64 // Vector multivariable: [PM10, PM2.5, SO2, NO2, CO]
	Cluster int   // Índice del centroide al que pertenece
}

// calcularDistancia aplica la fórmula de distancia euclidiana entre dos vectores.
func calcularDistancia(a, b []float64) float64 {
	sum := 0.0
	for i := range a {
		diff := a[i] - b[i]
		sum += diff * diff
	}
	return math.Sqrt(sum)
}

// kMeansConcurrente ejecuta el algoritmo de agrupamiento dividiendo la carga en múltiples hilos (Worker Pool).
func kMeansConcurrente(datos []Observacion, k int, maxIter int, numWorkers int) [][]float64 {
	numFeatures := len(datos[0].Features)
	centroides := make([][]float64, k)

	// 1. Inicialización: Seleccionar 'k' centroides iniciales al azar
	rand.Seed(time.Now().UnixNano())
	for i := 0; i < k; i++ {
		idx := rand.Intn(len(datos))
		centroides[i] = make([]float64, numFeatures)
		copy(centroides[i], datos[idx].Features)
	}

	// 2. Bucle principal de optimización
	for iter := 0; iter < maxIter; iter++ {
		cambiosTotales := 0
		var wg sync.WaitGroup
		var mu sync.Mutex // Protege la suma de los cambios totales para evitar Race Conditions

		// Calcular la cantidad de observaciones que procesará cada worker
		tamañoBloque := len(datos) / numWorkers

		// Fase A: Asignar cada observación al centroide más cercano (CONCURRENTE)
		for w := 0; w < numWorkers; w++ {
			inicio := w * tamañoBloque
			fin := inicio + tamañoBloque

			// El último worker procesa cualquier residuo de la división
			if w == numWorkers-1 {
				fin = len(datos)
			}

			wg.Add(1)

			// Lanzamiento de la Goroutine (Worker)
			go func(inicio, fin int) {
				defer wg.Done()
				cambiosLocal := 0 // Variable local para no bloquear la memoria en cada iteración

				for i := inicio; i < fin; i++ {
					minDist := math.MaxFloat64
					clusterAsignado := 0

					for j := 0; j < k; j++ {
						dist := calcularDistancia(datos[i].Features, centroides[j])
						if dist < minDist {
							minDist = dist
							clusterAsignado = j
						}
					}

					// Registrar si el punto cambió de grupo
					if datos[i].Cluster != clusterAsignado {
						datos[i].Cluster = clusterAsignado
						cambiosLocal++
					}
				}

				// Sección Crítica: Sumar los cambios del worker al contador global
				mu.Lock()
				cambiosTotales += cambiosLocal
				mu.Unlock()

			}(inicio, fin)
		}

		// Barrera: Esperar a que todos los workers terminen de asignar sus bloques
		wg.Wait()

		// Criterio de parada: Si ningún punto cambió de cluster, hemos terminado
		if cambiosTotales == 0 {
			fmt.Printf("-> Convergencia alcanzada en la iteración %d\n", iter)
			break
		}

		// Fase B: Recalcular la posición de los centroides (SECUENCIAL)
		// Se hace secuencial porque actualizar promedios compartidos generaría contención de memoria
		nuevosCentroides := make([][]float64, k)
		conteos := make([]int, k)
		for i := 0; i < k; i++ {
			nuevosCentroides[i] = make([]float64, numFeatures)
		}

		// Sumar los valores de todas las características por cluster
		for _, obs := range datos {
			c := obs.Cluster
			conteos[c]++
			for j := 0; j < numFeatures; j++ {
				nuevosCentroides[c][j] += obs.Features[j]
			}
		}

		// Dividir por la cantidad de puntos para obtener el nuevo centroide
		for i := 0; i < k; i++ {
			if conteos[i] > 0 {
				for j := 0; j < numFeatures; j++ {
					centroides[i][j] = nuevosCentroides[i][j] / float64(conteos[i])
				}
			}
		}
	}
	return centroides
}

func main() {
	rutaArchivo := "/content/drive/MyDrive/Concurrente/Procesado/dataset_kmeans_go.csv"

	file, err := os.Open(rutaArchivo)
	if err != nil {
		fmt.Printf("Error abriendo el archivo %s: %v\n", rutaArchivo, err)
		return
	}
	defer file.Close()

	reader := csv.NewReader(file)
	registros, err := reader.ReadAll()
	if err != nil {
		fmt.Println("Error leyendo el CSV:", err)
		return
	}

	var datasetBase []Observacion

	// Mapeo de columnas: 2:CO, 3:NO2, 4:PM10, 5:PM2.5, 6:SO2
	for i := 1; i < len(registros); i++ {
		valCO, _ := strconv.ParseFloat(registros[i][2], 64)
		valNO2, _ := strconv.ParseFloat(registros[i][3], 64)
		valPM10, _ := strconv.ParseFloat(registros[i][4], 64)
		valPM25, _ := strconv.ParseFloat(registros[i][5], 64)
		valSO2, _ := strconv.ParseFloat(registros[i][6], 64)

		obs := Observacion{
			Features: []float64{valPM10, valPM25, valSO2, valNO2, valCO},
			Cluster: -1,
		}
		datasetBase = append(datasetBase, obs)
	}

	// PRUEBA DE ESTRÉS: Multiplicador x1000 para evaluación
	var datasetMasivo []Observacion
	multiplicador := 1000
	for i := 0; i < multiplicador; i++ {
		datasetMasivo = append(datasetMasivo, datasetBase...)
	}

	fmt.Printf("Total de observaciones masivas procesadas: %d\n", len(datasetMasivo))

	// Configuración de hiperparámetros
	K := 3     // Cantidad de clusters a encontrar
	MaxIter := 100 // Límite de seguridad para evitar bucles infinitos
	NumWorkers := 4 // Cantidad de Goroutines dividiendo el trabajo

	// --- INICIO DE MEDICIÓN DE RENDIMIENTO ---
	inicio := time.Now()

	fmt.Printf("Ejecutando algoritmo K-Means Concurrente con %d Workers\n", NumWorkers)
	centroidesFinales := kMeansConcurrente(datasetMasivo, K, MaxIter, NumWorkers)

	duracion := time.Since(inicio)
	// --- FIN DE MEDICIÓN ---

	fmt.Printf("\n=== RESULTADOS CONCURRENTES ===\n")
	fmt.Printf("Tiempo de ejecución (T_concurrente): %v\n", duracion)
	fmt.Println("Centroides finales [PM10, PM2.5, SO2, NO2, CO]:")
	for i, c := range centroidesFinales {
		fmt.Printf(" Cluster %d: %.4f\n", i, c)
	}
}
