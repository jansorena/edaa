#!/bin/bash

# Directory where results will be saved
OUTPUT_DIR="./results"
mkdir -p $OUTPUT_DIR

# Number of runs per experiment
RUNS=100

# Configuration of limits and step to vary the target
LOWER=10000
UPPER=100000
STEP=10000

# Executables of the algorithms
EXECUTABLES=(
    "exe/avl_search" "exe/rb_search" "exe/sp_search" "exe/sl_search_most" "exe/sl_search_least" "exe/sl_search_same" \
    "exe/avl_insert" "exe/rb_insert" "exe/sp_insert" "exe/sl_insert"\
    "exe/avl_delete" "exe/rb_delete" "exe/sp_delete" "exe/sl_delete"
    )

# Algorithm names (for result files)
ALGORITHMS=(
    "avl_search" "rb_search" "sp_search" "sl_search_most" "sl_search_least" "sl_search_same"
    "avl_insert" "rb_insert" "sp_insert" "sl_insert"
    "avl_delete" "rb_delete" "sp_delete" "sl_delete"
    )

# Iterate over each executable and perform the tests
for i in ${!EXECUTABLES[@]}; do
    EXECUTABLE="./${EXECUTABLES[$i]}"
    ALGORITHM="${ALGORITHMS[$i]}"
    OUTPUT_FILE="$OUTPUT_DIR/results_${ALGORITHM}.csv"
    
    # Print message indicating which executable is running
    echo "Running ${ALGORITHM}..."

    # Run the program and redirect the output to a CSV file
    $EXECUTABLE $OUTPUT_FILE $RUNS $LOWER $UPPER $STEP

    echo "${ALGORITHM} completed, results saved in ${OUTPUT_FILE}"
done

echo "All experiments have been executed."