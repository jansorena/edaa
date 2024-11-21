#include <iostream>
#include <fstream>
#include <string>
#include <vector>
#include <random>

// Función para leer el texto desde un archivo
std::string read_text(const std::string& filename) {
    std::ifstream file(filename);
    if (!file) {
        std::cerr << "No se pudo abrir el archivo de texto." << std::endl;
        std::exit(EXIT_FAILURE);
    }
    std::string text((std::istreambuf_iterator<char>(file)), std::istreambuf_iterator<char>());
    return text;
}

// Función para seleccionar patrones aleatorios del texto
std::vector<std::string> select_random_patterns(const std::string& text, std::size_t pattern_length, std::size_t num_patterns) {
    std::vector<std::string> patterns;
    if (pattern_length > text.size()) {
        std::cerr << "La longitud del patrón es mayor que el tamaño del texto." << std::endl;
        return patterns;
    }

    std::random_device rd;
    std::mt19937 rng(rd());
    std::uniform_int_distribution<std::size_t> dist(0, text.size() - pattern_length);

    for (std::size_t i = 0; i < num_patterns; ++i) {
        std::size_t start_index = dist(rng);
        std::string pattern = text.substr(start_index, pattern_length);
        patterns.push_back(pattern);
    }

    return patterns;
}

int main() {
    // Ruta al archivo de texto
    std::string text_filename = "sources.50MB"; // Reemplaza con la ruta real
    // Leer el texto desde el archivo
    std::string text = read_text(text_filename);

    // Parámetros
    std::size_t pattern_length = 1000; // Longitud de los patrones
    std::size_t num_patterns = 100;  // Número de patrones a extraer

    // Obtener patrones aleatorios del texto
    std::vector<std::string> patterns = select_random_patterns(text, pattern_length, num_patterns);

    // Guardar los patrones en un archivo
    std::ofstream output_file("patterns_200.txt");
    if (!output_file) {
        std::cerr << "No se pudo crear el archivo de salida." << std::endl;
        return 1;
    }

    for (const auto& pattern : patterns) {
        output_file << pattern << std::endl;
    }
    output_file.close();

    std::cout << "Se han guardado " << patterns.size() << " patrones en 'patrones.txt'" << std::endl;

    return 0;
}