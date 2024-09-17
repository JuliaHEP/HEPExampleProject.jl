
@inline _rho(E,m) = sqrt(E^2 - m^2) 

"""
    differential_cross_section(E_in::Real, cos_theta::Real)

Calculates the differential cross section for the process ``e^+ e^- \\to \\mu^+ \\mu^-`` 
at tree level in quantum electrodynamics (QED). The calculation is performed in the center-of-momentum 
frame (CMS) as a function of the energy (`E_in`) of the incoming electron and the cosine of the 
scattering angle (`cos_theta`), i.e. the angle between the incoming electron and outgoing muon.

# Arguments
- `E_in::Real`: The energy of the electron/positron in MeV. In the center-of-momentum frame, this energy is equal to the energies of all incoming and outgoing particles.
- `cos_theta::Real`: The cosine of the scattering angle between the incoming electron and the outgoing muon.

# Methodology
This function computes the differential cross section using the following formula:

```math
\\frac{\\mathrm{d}\\sigma}{\\mathrm{d}\\Omega} = \\frac{\\alpha^2}{16 E_{\\mathrm{in}}^6}\\left( E_{\\text{in}}^4 + \\rho_e^2 \\rho_\\mu^2 \\cos^2\\theta + E_{\\text{in}}^2 \\left( m_e^2 + m_\\mu^2 \\right) \\right)
```

where:
- ``E_{\\text{in}}`` is the energy of the incoming electron/positron in CMS,
- ``\\rho_i = \\sqrt{E_{\\text{in}}^2 - m_i^2}`` are the magnitude of three-momenta of the electron (``i=e``) and muon (``i=\\mu``) in the center-of-mass frame,
- ``\\alpha`` is the fine-structure constant,
- ``m_e`` and ``m_\\mu`` are the masses of the electron and muon, respectively.

# Example
```julia
julia> E_in = 100.0
julia> cos_theta = 0.5
julia> differential_cross_section(E_in, cos_theta)
5.3623421e-10
```
"""
function differential_cross_section(E_in,cos_theta)
    # reminder: Ein == Eout
    rho_e  = _rho(E_in,ELECTRON_MASS)
    rho_mu = _rho(E_in,    MUON_MASS)

    prefac = ALPHA^2/(16*E_in^6)*rho_mu/rho_e
    return prefac*(
        E_in^4
        + rho_e^2*rho_mu^2*cos_theta^2
        + E_in^2*(ELECTRON_MASS^2 + MUON_MASS^2)
    )
end

function differential_cross_section_PS(E_in,cos_theta)
    rho_mu = _rho(E_in,    MUON_MASS)
    prefac = ALPHA^2/(16*E_in^5)*rho_mu
    return prefac*(E_in^2 + MUON_MASS^2 + rho_mu^2*cos_theta^2)
end



