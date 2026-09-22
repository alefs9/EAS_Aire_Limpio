package main

import (
	"encoding/csv"
	"fmt"
	"math"
	"math/rand"
	"os"
	"strconv"
	"time"
)

// Observacion representa una fila del dataset con sus 5 contaminantes.
type Observacion struct {
	Features []float64 // Vector multivariable: [PM10, PM2.5, SO2, NO2, CO]
	Cluster  int       // Índice del centroide al que pertenece
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

// kMeansSecuencial ejecuta el algoritmo de agrupamiento en un solo hilo.
func kMeansSecuencial(datos []Observacion, k int, maxIter int) [][]float64 {
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
		cambios := 0

		// Fase A: Asignar cada observación al centroide más cercano
		for i := range datos {
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
				cambios++
			}
		}

		// Criterio de parada: Si ningún punto cambió de cluster, hemos terminado
		if cambios == 0 {
			fmt.Printf("-> Convergencia alcanzada en la iteración %d\n", iter)
			break
		}

		// Fase B: Recalcular la posición de los centroides (promedio de sus puntos)
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

	var dataset []Observacion

	// Mapeo de columnas: 2:CO, 3:NO2, 4:PM10, 5:PM2.5, 6:SO2
	for i := 1; i < len(registros); i++ {
		valCO, _   := strconv.ParseFloat(registros[i][2], 64)
		valNO2, _  := strconv.ParseFloat(registros[i][3], 64)
		valPM10, _ := strconv.ParseFloat(registros[i][4], 64)
		valPM25, _ := strconv.ParseFloat(registros[i][5], 64)
		valSO2, _  := strconv.ParseFloat(registros[i][6], 64)
		
		obs := Observacion{
			Features: []float64{valPM10, valPM25, valSO2, valNO2, valCO},
			Cluster:  -1,
		}
		dataset = append(dataset, obs)
	}

	fmt.Printf("Total de observaciones procesadas: %d\n", len(dataset))

	// Configuración de hiperparámetros
	K := 3           // Cantidad de clusters a encontrar
	MaxIter := 100   // Límite de seguridad para evitar bucles infinitos

	// --- INICIO DE MEDICIÓN DE RENDIMIENTO ---
	inicio := time.Now()
	
	fmt.Println("Ejecutando algoritmo K-Means Secuencial")
	centroidesFinales := kMeansSecuencial(dataset, K, MaxIter)
	
	duracion := time.Since(inicio)
	// --- FIN DE MEDICIÓN ---

	fmt.Printf("\n=== RESULTADOS SECUENCIALES ===\n")
	fmt.Printf("Tiempo de ejecución (T_secuencial): %v\n", duracion)
	fmt.Println("Centroides finales [PM10, PM2.5, SO2, NO2, CO]:")
	for i, c := range centroidesFinales {
		fmt.Printf("  Cluster %d: %.4f\n", i, c)
	}
}
