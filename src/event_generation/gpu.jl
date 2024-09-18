#=

# TODO: 
# - pass seed instead of RNG obj
function generate_flat_event(rng::AbstractRNG,E_in::T) where {T<:Real}
    cth_arr = 2 * rand(rng) - 1
    phi_arr = (2*pi) * rand(rng) 
    weight = differential_cross_section(E_in,cth_arr)

    # don't use dicts!
    moms_dict_list = construct_from_coords(E_in,cth_arr,phi_arr)

    event= Event(moms_dict_list,weight)
   
    return event
end

function build_unweighting_mask(rng::AbstractRNG,E_in::T,event::Event) where T
    maximum_weight = max_weight(E_in)
    return weight >= rand(rng)*maximum_weight
end
 

function generate_event(rng::AbstractRNG,E_in)
    rng1,rng2 = get_rng(rng)
    event_list = generate_flat_event(rng1,E_in)
    return (event,build_unweighting_mask(rng2,E_in,event))
end

function do_the_thing(args)
    rng_list = CuVector{RNG}(...)
    res_list = Event{Float32}[]
    sizehint!(res_list,Size(nevents))
    
    n_run = 0
    while n_run >= nevents
        # TODO: check if E_in can be scalar
        event_records = generate_event.(rng_list,E_in)
        accepted_events,n = filter_events(event_records,...)
        append!(res_list,accepted_events) 
        n_run += n
    end
end
=#
