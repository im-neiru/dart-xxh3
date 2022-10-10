#include "exports.h"

void* create_state() {
    return XXH3_createState();
}

void destroy_state(XXH3_state_t* state) {
    XXH3_freeState(state);
}

int digest_64bits(XXH3_state_t* state, 
    const void* data, size_t length, char hash[8]) {

    XXH_errorcode errcode = XXH3_64bits_update(state, data, length);

    if(errcode == XXH_OK) {
        *((XXH64_hash_t*)hash) = XXH3_64bits_digest(state);
    }
    
    return errcode == XXH_OK;
}

int digest_128bits(XXH3_state_t* state, 
    const void* data, size_t length, char hash[16]) {
    XXH_errorcode errcode = XXH3_128bits_update(state, data, length);
    
    if(errcode == XXH_OK) {
        *((XXH128_hash_t*)hash) = XXH3_128bits_digest(state);
    }

    return errcode == XXH_OK;
}

int seed_64_bits(XXH3_state_t* state, unsigned long long seed) {
    XXH3_64bits_reset_withSeed(state, seed) == XXH_OK;
}

int seed_128_bits(XXH3_state_t* state, unsigned long long seed) {
    XXH3_128bits_reset_withSeed(state, seed) == XXH_OK;
}