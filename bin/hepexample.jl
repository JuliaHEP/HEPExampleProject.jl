using HEPExampleProject
using Random

function print_values(output::IO, p::FourMomentum)::Nothing
    (; en, x, y, z) = p
    return print(output, en, ", ", x, ", ", y, ", ", z)
end

function print_values(output::IO, evt::Event)::Nothing
    (; electron_momentum, positron_momentum, muon_momentum, anti_muon_momentum, weight) =
        evt
    print_values(output, electron_momentum)
    print(output, ", ")
    print_values(output, positron_momentum)
    print(output, ", ")
    print_values(output, muon_momentum)
    print(output, ", ")
    print_values(output, anti_muon_momentum)
    print(output, ", ")
    return print(output, weight)
end

# Main entry point compatible with Julia < 1.11
# For Julia >= 1.11, you can use the `function (@main)(args)` macro instead
function main(args)
    n_events = 20

    rng = Xoshiro(137)
    incoming_electron_energy = 1000.0
    event_list = generate_events_cpu(rng, incoming_electron_energy, n_events)

    for evt in event_list
        print_values(Core.stdout, evt)
        println(Core.stdout)
    end

    return 0
end

# Compatibility with Julia < 1.11
# Not needed for Julia >= 1.11 if using `function (@main)(args)`
@static @isdefined(var"@main") ? (@main) : main(ARGS)
