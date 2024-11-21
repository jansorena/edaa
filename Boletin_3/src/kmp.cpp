#ifndef KMP_H
#define KMP_H

#include <string_view>
#include <vector>

class KMP {
private:
    std::string_view pattern;
    std::vector<int64_t> prefix_table;

    // Preprocess the pattern to build prefix table
    void buildPrefixTable() {
        int64_t m = pattern.length();
        prefix_table.resize(m + 1);
        prefix_table[0] = -1;

        int64_t j = 0;
        for (int64_t i = 1; i < m; i++) {
            if (pattern[i] == pattern[j]) {
                prefix_table[i] = prefix_table[j];
            } else {
                prefix_table[i] = j;
                while (j >= 0) {
                    if (pattern[i] == pattern[j])
                        break;
                    j = prefix_table[j];
                }
            }
            j++;
        }
        prefix_table[m] = j;
    }

public:
    // Constructor takes the pattern and preprocesses it
    KMP(std::string_view pattern_) : pattern(pattern_) {
        buildPrefixTable();
    }

    // Search for pattern in text, returns number of matches
    int64_t search(std::string_view text) const {
        int64_t matches = 0;
        int64_t n = text.length();
        int64_t m = pattern.length();

        // If pattern larger than text, then no matches
        if (m > n)
            return 0;

        int64_t i = 0;  // index for text
        int64_t j = 0;  // index for pattern
        
        while (i < n) {
            if (text[i] == pattern[j]) {
                i++;
                j++;
                // Match is found if end of pattern is reached
                if (j == m) {
                    matches++;
                    j = prefix_table[j]; // Roll-back to next candidate position
                }
            } else {
                j = prefix_table[j];
                // Only move text if rolled-back all the way to start of pattern
                if (j < 0) {
                    i++;
                    j++;
                }
            }
        }

        return matches;
    }

    std::int64_t memory_usage() const {
        std::int64_t total_memory = 0;

        // pattern
        total_memory += sizeof(char) * pattern.size();

        // prefix_table
        total_memory += sizeof(int64_t) * prefix_table.size();

        return total_memory;
    }
};

#endif