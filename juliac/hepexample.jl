module RunHEPExample

using HEPExampleProject
using Random


function print_values(output::IO, p::FourMomentum)::Nothing
    (;en, x, y, z) = p
    print(output, en, ", ", x, ", ", y, ", ", z)
end


function print_values(output::IO, evt::Event)::Nothing
    (;electron_momentum, positron_momentum, muon_momentum, anti_muon_momentum, weight) = evt
    print_values(output, electron_momentum); print(output, ", ")
    print_values(output, positron_momentum); print(output, ", ")
    print_values(output, muon_momentum); print(output, ", ")
    print_values(output, anti_muon_momentum); print(output, ", ")
    print(output, weight)
end


Base.@ccallable function main()::Cint
    n_events = 20
    
    rng = Xoshiro(137)
    incoming_electron_energy = 1000.0
    event_list = generate_events_cpu(rng,incoming_electron_energy, n_events)
    
    for evt in event_list
        print_values(Core.stdout, evt)
        println(Core.stdout)
    end

    return zero(Cint)
end

end # module RunHEPExample

# # In Julia, test with
# RunHEPExample.main()
