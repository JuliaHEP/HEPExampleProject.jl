"""
    Event(
        electron_momentum,
        positron_momentum,
        muon_momentum,
        anti_muon_momentum,
        weight
    )

Represents a single event in the process ``e^+ e^- \\to \\mu^+ \\mu^-``, containing the four-momenta 
of the electron, and positron in the initial state and muon, and anti-muon in the final state, along 
with the corresponding event weight.

# Fields
- `electron_momentum::FourMomentum`: The four-momentum of the incoming electron.
- `positron_momentum::FourMomentum`: The four-momentum of the incoming positron.
- `muon_momentum::FourMomentum`: The four-momentum of the outgoing muon.
- `anti_muon_momentum::FourMomentum`: The four-momentum of the outgoing anti-muon.
- `weight::T`: The weight of the event, representing the likelihood of the event occurring. Must be non-negative.


# Example
```jldoctest
julia> p_electron = FourMomentum(10.0, 0.0, 0.0, 9.0)
FourMomentum(en = 10.0, x = 0.0, y = 0.0, z = 9.0)


julia> p_positron = FourMomentum(10.0, 0.0, 0.0, -9.0)
FourMomentum(en = 10.0, x = 0.0, y = 0.0, z = -9.0)


julia> p_muon = FourMomentum(9.5, 2.0, 1.0, 8.0)
FourMomentum(en = 9.5, x = 2.0, y = 1.0, z = 8.0)


julia> p_anti_muon = FourMomentum(10.5, -2.0, -1.0, -8.0)
FourMomentum(en = 10.5, x = -2.0, y = -1.0, z = -8.0)


julia> weight = 1.2
1.2

julia> event = Event(p_electron, p_positron, p_muon, p_anti_muon, weight)
Event e-e+ -> mu-mu+
	electron:  (10.0, 0.0, 0.0, 9.0)

	positron:  (10.0, 0.0, 0.0, -9.0)

	muon:      (9.5, 2.0, 1.0, 8.0)

	anti muon: (10.5, -2.0, -1.0, -8.0)

	weight:    1.2
```
"""
struct Event{T}
    #
    # FIXME: add in more fields here
    #
    weight::T

    function Event(
        electron_momentum::FourMomentum{T},
        positron_momentum::FourMomentum{T},
        muon_momentum::FourMomentum{T},
        anti_muon_momentum::FourMomentum{T},
        weight::T) where {T<:Real}

        #
        # FIXME: add some validation 
        #
        return new{T}(electron_momentum,positron_momentum,muon_momentum,anti_muon_momentum,weight)
    end
end

# construct event from momentum dict
Event(d::Dict,weight) = Event(d["e-"],d["e+"],d["mu-"],d["mu+"],weight)

# construct event from coordinates
function Event(E_in::Real,cos_theta::Real,phi::Real,weight::Real)
    #
    # FIXME: add me 
    #
end

# easy access of element type
Base.eltype(::Event{T}) where T = T

# pretty printing for events
function Base.show(io::IO,event::Event)
    println(io,"Event(w=$(event.weight))")
    return nothing
end
function Base.show(io::IO, m::MIME"text/plain", event::Event)
    println(io,"""
            Event e-e+ -> mu-mu+
            \telectron:  $(event.electron_momentum)
            \tpositron:  $(event.positron_momentum)
            \tmuon:      $(event.muon_momentum)
            \tanti muon: $(event.anti_muon_momentum)
            \tweight:    $(event.weight)
            """)
    return nothing
end

###
# accessor functions
# see FourMomentumBase.jl for a more exhaused list
###

function muon_cos_theta(event)
    muon_mom = event.muon_momentum
    rho_muon = sqrt(muon_mom.x^2 + muon_mom.y^2 + muon_mom.z^2)
    return iszero(rho_muon) ? one(rho_muon) : muon_mom.z / rho_muon
end

function muon_rapidity(event)
    muon_mom = event.muon_momentum
    en =  muon_mom.en
    zcomp = muon_mom.z 
    return 0.5 * log((en + zcomp) / (en - zcomp))
end
