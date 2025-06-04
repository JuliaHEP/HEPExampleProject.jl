#ifndef HEPEXAMPLE_H
#define HEPEXAMPLE_H

typedef struct {
    double en;
    double x;
    double y;
    double z;
} FourMomentum;

typedef struct {
    FourMomentum electron_momentum;
    FourMomentum positron_momentum;
    FourMomentum muon_momentum;
    FourMomentum anti_muon_momentum;

    double weight;
} Event;


#ifdef __cplusplus
extern "C" {
#endif

// Type definitions for function pointers
typedef void (*jl_init_with_image_t)(const char *bindir, const char *sysimage);
typedef int (*genevents_t)(Events events*, int nevents);

#ifdef __cplusplus
}
#endif

#endif // HEPEXAMPLE_H
