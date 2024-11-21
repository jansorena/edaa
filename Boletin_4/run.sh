#!/bin/bash

# Directory where results will be saved
OUTPUT_DIR="./results"
mkdir -p $OUTPUT_DIR

# Number of runs per experiment
RUNS=1000

# Configuration of limits and step to vary the target
LOWER=10000
UPPER=100000
STEP=10000

# Compile all the programs
g++ -std=c++20 -O0 -Wall -Wpedantic -o exe/uhr_st_query experiments/uhr_st_query.cpp
g++ -std=c++20 -O0 -Wall -Wpedantic -o exe/uhr_st_query_idem experiments/uhr_st_query_idem.cpp
g++ -std=c++20 -O0 -Wall -Wpedantic -o exe/uhr_st_full experiments/uhr_st_full.cpp
g++ -std=c++20 -O0 -Wall -Wpedantic -o exe/uhr_st_construction experiments/uhr_st_construction.cpp
g++ -std=c++20 -O0 -Wall -Wpedantic -o exe/uhr_sg_update experiments/uhr_sg_update.cpp
g++ -std=c++20 -O0 -Wall -Wpedantic -o exe/uhr_sg_query experiments/uhr_sg_query.cpp
g++ -std=c++20 -O0 -Wall -Wpedantic -o exe/uhr_sg_full experiments/uhr_sg_full.cpp
g++ -std=c++20 -O0 -Wall -Wpedantic -o exe/uhr_sg_construction experiments/uhr_sg_construction.cpp

# Executables of the algorithms
EXECUTABLES=(
    "./exe/uhr_st_query"
    "./exe/uhr_st_query_idem"
    "./exe/uhr_st_full"
    "./exe/uhr_st_construction"
    "./exe/uhr_sg_update"
    "./exe/uhr_sg_query"
    "./exe/uhr_sg_full"
    "./exe/uhr_sg_construction"
)

# Algorithm names (for result files)
ALGORITHMS=(
    "uhr_st_query"
    "uhr_st_query_idem"
    "uhr_st_full"
    "uhr_st_construction"
    "uhr_sg_update"
    "uhr_sg_query"
    "uhr_sg_full"
    "uhr_sg_construction"
)

# Iterate over each executable and perform the tests
for i in ${!EXECUTABLES[@]}; do
    EXECUTABLE="${EXECUTABLES[$i]}"
    ALGORITHM="${ALGORITHMS[$i]}"
    OUTPUT_FILE="$OUTPUT_DIR/results_${ALGORITHM}.csv"
    
    echo "Running ${ALGORITHM}..."

    # Run the program and redirect the output to a CSV file
    $EXECUTABLE $OUTPUT_FILE $RUNS $LOWER $UPPER $STEP

    echo "${ALGORITHM} completed successfully. Results saved in ${OUTPUT_FILE}"
    echo ""
done

echo "All tests completed successfully."