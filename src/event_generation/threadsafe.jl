
# TODO: 
# - pass seed instead of RNG obj
function generate_flat_event(E_in::T) where {T<:Real}
    cth = 2 * rand(T) - 1
    phi = rand(T) 
    weight = differential_cross_section(E_in,cth)

    event= Event(E_in,cth,phi,weight)
    return event
end

function build_unweighting_mask(E_in::T,event) where T
    maximum_weight = max_weight(E_in)
    return event.weight >= rand(T)*maximum_weight
end
 

function generate_event_and_masks(E_in)
    event = generate_flat_event(E_in)
    return (event,build_unweighting_mask(E_in,event))
end

function filter_accepted(record_list)
    T = eltype(record_list[1][1])
    accepted_events = Event{T}[]

    for record in record_list
        if record[2]
            push!(accepted_events,record[1])
        end
    end
    return accepted_events
end

function generate_events(
    E_in::T,
    nevents; 
    array_type::Type{ARRAY_TYPE}=Vector{T}, 
    chunksize = 1000
) where {
        T<:Real,
        ARRAY_TYPE<:AbstractVector{T}
    }

    unweighted_events = Event{T}[]
    sizehint!(unweighted_events,nevents)

    E_in_vec = array_type(undef,chunksize)
    fill!(E_in_vec,E_in)
    nrun = 0

    while nrun<=nevents
        event_records = generate_event_and_masks.(E_in_vec)
        event_records_cpu = Vector(event_records)
        accepted_events = filter_accepted(event_records_cpu)
        nrun += length(accepted_events)
        append!(unweighted_events,accepted_events)
    end

    return unweighted_events
end
