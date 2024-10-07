#!/bin/bash

# Directorio donde se guardarán los resultados
OUTPUT_DIR="./results"
mkdir -p $OUTPUT_DIR

# Número de ejecuciones por experimento
RUNS=4000

# Configuración de los límites y el paso para variar el target
LOWER=10000
UPPER=100000
STEP=10000

# Ejecutables de los algoritmos
EXECUTABLES=("exe/sequential_search_exp1" "exe/binary_search_exp1" "exe/galloping_search_exp1")

# Nombres de los algoritmos (para los archivos de resultados)
ALGORITHMS=("sequential_exp1" "binary_exp1" "galloping_exp1")

# Iterar sobre cada ejecutable y realizar las pruebas
for i in ${!EXECUTABLES[@]}; do
    EXECUTABLE="./${EXECUTABLES[$i]}"
    ALGORITHM="${ALGORITHMS[$i]}"
    OUTPUT_FILE="$OUTPUT_DIR/results_${ALGORITHM}.csv"
    
    # Imprimir mensaje indicando qué ejecutable se está ejecutando
    echo "Ejecutando ${ALGORITHM}..."

    # Ejecutar el programa y redirigir el resultado a un archivo CSV
    $EXECUTABLE $OUTPUT_FILE $RUNS $LOWER $UPPER $STEP

    echo "${ALGORITHM} completado, resultados guardados en ${OUTPUT_FILE}"
done

echo "Todos los experimentos han sido ejecutados."