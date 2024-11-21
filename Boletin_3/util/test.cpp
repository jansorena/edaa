#include <iostream>
#include <string>
#include <vector>
#include <algorithm>
#include <fstream>
#include "../src/suffix_array.cpp"
#include "../src/kmp.cpp"
#include <random>
#include <sstream>

std::string load_text(const std::string& filename) {
    std::ifstream infile(filename);
    std::stringstream buffer;
    buffer << infile.rdbuf();
    return buffer.str();
}

std::string generate_random_pattern(std::size_t length, std::mt19937_64& rng) {
    const std::string bases = "ACGT";
    std::uniform_int_distribution<std::size_t> dist(0, bases.size() - 1);
    std::string pattern;
    pattern.reserve(length); // Reservar espacio para mejorar el rendimiento

    for (std::size_t i = 0; i < length; ++i) {
        char base = bases[dist(rng)];
        pattern += base;
    }

    return pattern;
}

int main(){
    // Read text from file
    std::cout << "Size of int_64_t: " << sizeof(std::int64_t) << std::endl;
    return 0;
}