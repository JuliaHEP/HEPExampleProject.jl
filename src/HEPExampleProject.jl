module HEPExampleProject

using Random

# export some symbols

export ELECTRON_MASS, MUON_MASS, ALPHA

export differential_cross_section, total_cross_section
export FourMomentum, minkowski_dot, coords_to_dict 

export Event
export muon_cos_theta, muon_rapidity

export generate_flat_events_cpu, generate_events_cpu, max_weight

export plot_muon_cos_theta 

# Write your package code here.
include("constants.jl")
include("four_momentum.jl")
include("cross_section.jl")
include("events.jl")
include("event_generation/serial.jl")
include("event_generation/threadsafe.jl")
include("plotting.jl")
include("utils.jl")

end
