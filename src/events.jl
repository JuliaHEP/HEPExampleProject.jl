# TODO: add check for energy momentum conservation

struct Event{T}
    electron_momentum::FourMomentum{T}
    positron_momentum::FourMomentum{T}
    muon_momentum::FourMomentum{T}
    anti_muon_momentum::FourMomentum{T}

    weight::T

    function Event(
        electron_momentum::FourMomentum{T},
        positron_momentum::FourMomentum{T},
        muon_momentum::FourMomentum{T},
        anti_muon_momentum::FourMomentum{T},
        weight::T) where {T<:Real}

        weight >=0.0 || throw(
            ArgumentError(
                "weight $weight must be non-negative"
            )
        )

        return new{T}(electron_momentum,positron_momentum,muon_momentum,anti_muon_momentum,weight)
    end
end

# construct event from momentum dict
Event(d::Dict,weight) = Event(d["e-"],d["e+"],d["mu-"],d["mu+"],weight)

# pretty printing for events
function Base.show(io::IO,event::Event)
    println("""
            Event e-e+ -> mu-mu+\n
            \telectron:  $(event.electron_momentum)
            \tpositron:  $(event.positron_momentum)
            \tmuon:      $(event.muon_momentum)
            \tanti muon: $(event.anti_muon_momentum)
            """)
    return nothing
end

###
# accessor functions
# see FourMomentumBase.jl for a more exhaused list
###

function _muon_cos_theta(event)
    muon_mom = event.muon_momentum
    rho_muon = sqrt(muon_mom.x^2 + muon_mom.y^2 + muon_mom.z^2)
    return iszero(rho_muon) ? one(rho_muon) : muon_mom.z / rho_muon
end

function _muon_rapidity(event)
    muon_mom = event.muon_momentum
    en =  muon_mom.en
    zcomp = muon_mom.z 
    return 0.5 * log((en + zcomp) / (en - zcomp))
end
