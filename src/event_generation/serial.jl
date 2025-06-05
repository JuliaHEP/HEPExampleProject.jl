"""
    max_weight(E_in)

Return the maximum weight, i.e. the maxmaximum value of [`differential_cross_section`](@ref) for specified initial electron energy `E_in. 

# Example
```jldoctest
julia> max_weight(1e3)
6.619160791345756e-12
```
"""
function max_weight(E_in)
    differential_cross_section(E_in,-1) 
end

"""
    generate_flat_events_cpu(rng::AbstractRNG, E_in::Real, nevents::Int)

Generates a list of weighted events for the process ``e^+ e^- \\to \\mu^+ \\mu^-`` using a 
flat random distribution in the cosine of the scattering angle and azimuthal angle.

# Arguments
- `rng::AbstractRNG`: A random number generator instance, used for sampling random numbers.
- `E_in::Real`: The energy of the incoming electron.
- `nevents::Int`: The number of events to generate.

# Returns
- `event_list`: A list of `Event` objects, where each event contains:

# Methodology
1. Randomly generates the cosine of the scattering angle (`cos_theta`) and azimuthal angle (`phi`) for each event.
2. Uses the [`differential_cross_section`](@ref) to compute the weights for each event.
3. Constructs the four-momenta of the outgoing muons and anti-muons from the random angles and the input energy `E_in`.
4. Returns a list of [`Event`](@ref) objects containing the momenta and corresponding event weights.

# Example
```julia
julia> rng = MersenneTwister(137)
julia> event_list = generate_flat_events_cpu(rng, 1e3, 1000);
```
The `;` should be used at the end of the last promt to suppress printing the whole event list.

# Notes
- This method generates weighted events where the weights are derived from the differential cross section. For unweighted events, use [`generate_events_cpu`](@ref).
"""
function generate_flat_events_cpu(rng::AbstractRNG,E_in::T,nevents::Int) where {T<:Real}
    cth_arr = 2 .* rand(rng,nevents) .- 1
    #
    # FIXME: fill in the rest
    # 
end


"""
    generate_events_cpu(rng::AbstractRNG, E_in::Real, nevents::Int) 

Generates a list of unweighted events for the process ``e^+ e^- \\to \\mu^+ \\mu^-`` using 
the acceptance-rejection method. The events are generated according to the 
[`differential_cross_section`](@ref).

# Arguments
- `rng::AbstractRNG`: A random number generator instance, used for sampling random numbers.
- `E_in::Real`: The center-of-mass energy of the incoming particles. 
- `nevents::Int`: The number of unweighted events to generate.

# Returns
- `unweighted_events`: A list of [`Event`](@ref) objects. 

# Methodology
1. The function generates trial events by randomly sampling `cos_theta` and calculating the event weight from the differential cross section.
2. Events are accepted if the sampled weight passes an acceptance-rejection test, where the probability of acceptance is proportional to the event weight.
3. The azimuthal angle (`phi`) is randomly sampled for accepted events, and the corresponding four-momenta for the incoming electron and positron, as well as the outgoing muons are constructed.
4. This process repeats until the desired number of events (`nevents`) is generated.

# Example
```julia
julia> rng = MersenneTwister(137)
julia> unweighted_events = generate_events_cpu(rng, 1e3, 1000);
```
"""
function generate_events_cpu(rng::AbstractRNG,E_in::T,nevents::Int) where {T<:Real}
    #
    # FIXME: fill me in
    #
end

