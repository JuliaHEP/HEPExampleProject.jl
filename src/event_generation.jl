function max_weight(E_in)
    differential_cross_section(E_in,-1) 
end

#=
function generate_flat_events_serial(rng::AbstractRNG,E_in::T,nevents) where {T<:Real}
    cth_arr = 2 .* rand(rng,nevents) .- 1
    phi_arr = (2*pi) .* rand(rng,nevents) 
    weigth_list = differential_cross_section.(E_in,cth_arr)

    moms_dict_list = _construct_from_coords.(E_in,cth_arr,phi_arr)

    event_list = Event.(moms_dict_list,weigth_list)
   
    return event_list
end

function build_unweightnig_mask(rng::AbstractRNG,event_list)
    unweighting_mask = Vector{Bool}(undef,length(event_list)) 

    for i in 1:nevents
    end
end
=#


function generate_flat_events_serial(rng::AbstractRNG,E_in::T,nevents::Int) where {T<:Real}
    unweighted_events = Vector{Event{T}}(undef,nevents)
    maximum_weight = max_weight(E_in)
   
    j = 1
    while true
        cth_trail = 2*rand(rng)-1

        weight = differential_cross_section(E_in,cth_trail)

        if weight >= rand(rng)*maximum_weight
            phi_trail = 2*pi*rand(rng)

            moms_dict = _construct_from_coords(E_in,cth_trail,phi_trail)
            unweighted_events[j] = Event(moms_dict,weight)
            if j == nevents
                break
            else
                j += 1
            end
        end
    end
    return unweighted_events
end
