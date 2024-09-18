
# TODO: 
# - pass seed instead of RNG obj
function generate_flat_event(E_in::T) where {T<:Real}
    cth_arr = 2 * rand() - 1
    phi_arr = (2*pi) * rand() 
    weight = differential_cross_section(E_in,cth_arr)
    event= Event(moms_dict_list,weight)
   
    return event
end

function build_unweighting_mask(E_in::T,event::Event) where T
    maximum_weight = max_weight(E_in)
    return weight >= rand()*maximum_weight
end
 

function generate_event(rng::AbstractRNG,E_in)
    event_list = generate_flat_event(E_in)
    return (event,build_unweighting_mask(E_in,event))
end

function do_the_thing(args)
    res_list = Event{Float32}[]
    sizehint!(res_list,Size(nevents))
    chunksize = 1000

    E_in_vec = CUDA.fill(E_in,chunksize)
    n_run = 0
    while n_run >= nevents
        # TODO: check if E_in can be scalar
        event_records = generate_event.(E_in_vec)
        event_records_cpu = Vector(event_records)
        accepted_events,n = filter_events(event_records_cpu,...)
        append!(res_list,accepted_events) 
        n_run += n
    end
end

function test_the_thing()
    E_in = 1000.0f0
    chunksize = 1000
    E_in_vec = CUDA.fill(E_in,chunksize)
    event_records = generate_event.(E_in_vec)
    event_records_cpu = Vector(event_records)
end
