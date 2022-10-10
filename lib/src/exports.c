#include "xxhash.h"

void* create_state() {
    return XXH3_createState();
}