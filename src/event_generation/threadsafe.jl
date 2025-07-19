
"""
    generate_flat_event(E_in::T) where {T<:Real}

Generate a flat event with a given incoming energy `E_in`. The event is characterized by a randomly sampled
cosine of the polar angle (`cth`), azimuthal angle (`phi`), and a weight. The weight is computed using the 
differential cross-section for the process.

# Arguments
- `E_in::T`: Incoming energy of the event (must be a subtype of `Real`).

# Returns
- An `Event` object containing the generated event's properties.
"""
function generate_flat_event(E_in::T) where {T<:Real}
    cth = 2 * rand(T) - 1
    phi = 2 * pi * rand(T)
    weight = differential_cross_section(E_in, cth)

    event = Event(E_in, cth, phi, weight)
    return event
end

"""
    build_unweighting_mask(E_in::T, event) where T

Build a mask to unweight events using the rejection sampling method. The mask filters events based on their
weights, comparing each event's weight against a random value scaled by the maximum weight for the given 
incoming energy `E_in`.

# Arguments
- `E_in::T`: Incoming energy of the event (must be a subtype of `Real`).
- `event`: The `Event` object whose weight will be compared.

# Returns
- A Boolean value indicating whether the event passes the unweighting criterion (`true` if accepted, `false` otherwise).
"""
function build_unweighting_mask(E_in::T, event) where {T}
    maximum_weight = max_weight(E_in)
    return event.weight >= rand(T) * maximum_weight
end

"""
    generate_event_and_masks(E_in)

Generate an event along with its unweighting mask. The mask is built based on the event's weight compared to 
a randomly scaled maximum weight (see [`build_unweighting_mask`](@ref) for details).

# Arguments
- `E_in`: Energy of the incoming electron (can be any `Real` type).

# Returns
- A tuple containing:
  - `event`: The generated event.
  - `mask`: A Boolean indicating whether the event is accepted or rejected based on its weight.
"""
function generate_event_and_masks(E_in)
    event = generate_flat_event(E_in)
    return (event, build_unweighting_mask(E_in, event))
end

"""
    filter_accepted(record_list)

Filter out and return only the accepted events from a list of event records. Each record contains an event 
and a Boolean mask indicating whether the event was accepted.

# Arguments
- `record_list`: A list of tuples where each tuple contains an `Event` and a corresponding Boolean mask.

# Returns
- A list of accepted `Event` objects.
"""
function filter_accepted(record_list)
    T = eltype(record_list[1][1])
    accepted_events = Event{T}[]

    for record in record_list
        if record[2]
            push!(accepted_events, record[1])
        end
    end
    return accepted_events
end

"""
    generate_events(E_in::T, nevents; array_type::Type{ARRAY_TYPE}=Vector{T}, chunksize=100) 
    where {T<:Real, ARRAY_TYPE<:AbstractVector{T}}

Generate a specified number of unweighted events using rejection sampling. Events are generated in chunks, 
and only accepted events are retained.

# Arguments
- `E_in::T`: Energy of the incoming electron (must be a subtype of `Real`).
- `nevents`: The number of unweighted events to generate.
- `array_type::Type{ARRAY_TYPE}`: Optional; the type of array to use for the internal event generation (default is `Vector{T}`).
- `chunksize`: Optional; the number of events to generate per chunk (default is 100).

# Returns
- A list of unweighted `Event` objects.
"""
function generate_events(
    E_in::T, nevents; array_type::Type{ARRAY_TYPE}=Vector{T}, chunksize=100
) where {T<:Real,ARRAY_TYPE<:AbstractVector{T}}
    unweighted_events = Event{T}[]
    sizehint!(unweighted_events, nevents)

    E_in_vec = array_type(undef, chunksize)
    fill!(E_in_vec, E_in)
    nrun = 0

    while nrun <= nevents
        event_records = generate_event_and_masks.(E_in_vec)
        event_records_cpu = Vector(event_records)
        accepted_events = filter_accepted(event_records_cpu)
        nrun += length(accepted_events)
        append!(unweighted_events, accepted_events)
    end

    return unweighted_events
end
