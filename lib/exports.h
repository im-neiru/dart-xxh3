#include "xxhash.h"

void* create_state();

void destroy_state(XXH3_state_t* state);

int digest_64bits(XXH3_state_t* state, 
    const void* data, size_t length, char hash[8]);

int digest_128bits(XXH3_state_t* state, 
    const void* data, size_t length, char hash[16]);

int seed_64_bits(XXH3_state_t* state, unsigned long long seed);

int seed_128_bits(XXH3_state_t* state, unsigned long long seed);