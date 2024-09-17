module HEPExampleProject

using Random

# export some symbols
export differential_cross_section
export FourMomentum, minkowski_dot, construct_from_coords

export Event
export muon_cos_theta, muon_rapidity

export generate_flat_events_serial

# Write your package code here.
include("constants.jl")
include("four_momentum.jl")
include("differential_cross_section.jl")
include("events.jl")
include("event_generation.jl")
end
