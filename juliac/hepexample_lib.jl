module HEPExampleLib

using HEPExampleProject
using Random

Base.@ccallable function genevents(evts_ptr::Ptr{Event}, nevents::Cint)::Cint
    rng = Xoshiro(137)
    incoming_electron_energy = 1000.0
    event_list = generate_events_cpu(rng,incoming_electron_energy, nevents)
    #evts = unsafe_wrap(Array, evts_ptr, nevents)
    #evts .= event_list
    return Cint(0)
end


end # module HEPExampleLib
