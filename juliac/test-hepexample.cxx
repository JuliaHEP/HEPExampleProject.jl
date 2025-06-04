#include <stdio.h>
#include <stdlib.h>
#include <dlfcn.h>
// #include <julia.h>
#include "juliac_library.h"

// Path to julia binary folder
#define JULIA_PATH "/opt/julia-1.12/bin/" // NOTE: modify this path

// Path to juliac compiled shared object file
#define LIB_PATH "./juliac_library.so" // NOTE: modify this path

int main() {
    // Load the shared library
    printf("Loading juliac_library.so\n");
    void *lib_handle = dlopen(LIB_PATH, RTLD_LAZY);
    if (!lib_handle) {
        fprintf(stderr, "Error: Unable to load library %s\n", dlerror());
        exit(EXIT_FAILURE);
    }
    printf("Loaded juliac_library.so\n");

    // Locate the julia functions function
    printf("Finding symbols\n");
    jl_init_with_image_t jl_init_with_image = (jl_init_with_image_t)dlsym(lib_handle, "jl_init_with_image");

    genevents_t genevents = (genevents_t) dlsym(lib_handle, "genevents");


    if (jl_init_with_image == NULL || genevents == NULL) {
        char *error = dlerror();
        fprintf(stderr, "Error: Unable to find symbol: %s\n", error);
        exit(EXIT_FAILURE);
    }
    printf("Found all symbols!\n");

    // Init julia
    jl_init_with_image(JULIA_PATH, LIB_PATH);

    int result = genevents_t(x, u, y[t])

    return 0;
}
