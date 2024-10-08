#!/bin/bash

# Directory where results will be savedOUTPUT_DIR="./results"
mkdir -p $OUTPUT_DIR

# Number of runs per experiment
RUNS=4000

# Configuration of limits and step to vary the target
LOWER=10000
UPPER=100000
STEP=10000

# Executables of the algorithms
EXECUTABLES=(
    "exe/sequential_search_exp1" "exe/binary_search_exp1" "exe/galloping_search_exp1" \
    "exe/sequential_search_exp2" "exe/binary_search_exp2" "exe/galloping_search_exp2"
)

# Algorithm names (for result files)
ALGORITHMS=("sequential_exp1" "binary_exp1" "galloping_exp1" "sequential_exp2" "binary_exp2" "galloping_exp2")

# Iterate over each executable and perform the tests
for i in ${!EXECUTABLES[@]}; do
    EXECUTABLE="./${EXECUTABLES[$i]}"
    ALGORITHM="${ALGORITHMS[$i]}"
    OUTPUT_FILE="$OUTPUT_DIR/results_${ALGORITHM}.csv"
    
    # Print message indicating which executable is running
    echo "Ejecutando ${ALGORITHM}..."

    # Run the program and redirect the output to a CSV file
    $EXECUTABLE $OUTPUT_FILE $RUNS $LOWER $UPPER $STEP

    echo "${ALGORITHM} completado, resultados guardados en ${OUTPUT_FILE}"
done

echo "Todos los experimentos han sido ejecutados."