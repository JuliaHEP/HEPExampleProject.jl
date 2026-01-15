
@inline function _rho(E,m) 
    #
    # FIXME: implement this!
    #
end

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
This function computes the differential cross section using the following formula (from Schwartz 2014):

```math
\\frac{\\mathrm{d}\\sigma}{\\mathrm{d}\\Omega} = \\frac{\\alpha^2}{16 E_{\\mathrm{in}}^6}\\left( E_{\\text{in}}^4 + \\rho_e^2 \\rho_\\mu^2 \\cos^2\\theta + E_{\\text{in}}^2 \\left( m_e^2 + m_\\mu^2 \\right) \\right)
```

where:
- ``E_{\\text{in}}`` is the energy of the incoming electron/positron in CMS,
- ``\\rho_i = \\sqrt{E_{\\text{in}}^2 - m_i^2}`` are the magnitude of three-momenta of the electron (``i=e``) and muon (``i=\\mu``) in the center-of-mass frame,
- ``\\alpha`` is the fine-structure constant,
- ``m_e`` and ``m_\\mu`` are the masses of the electron and muon, respectively.

# Example

```jldoctest
julia> E_in = 1e3 # MeV
1000.0

julia> cos_theta = 0.5
0.5

julia> differential_cross_section(E_in, cos_theta)
4.164686491998452e-12
```

# References
- Schwartz 2014: M.D. Schwartz, "Quantum Field Theory and the Standard Model", Cambridge University Press, New York (2014)
"""
function differential_cross_section(E_in, cos_theta)
    #
    # FIXME: fill me in
    #
end

"""
    total_cross_section(E_in::Real)

Calculates the total cross section for the process ``e^+ e^- \\to \\mu^+ \\mu^-`` at tree level,
as a function of the initial electron energy `E_in`.

# Arguments
- `E_in::Real`: The energy of the initial electron/positron in MeV.

# Methodology 
The calculation is based on the analytical integration of the [`differential_cross_section`](@ref) and uses the following formula for the total cross section:

```math
\\mathrm{d}\\sigma(E_in) = \\frac{\\pi \\alpha^2}{8 E_{\\text{in}}^6} \\cdot \\frac{\\rho_\\mu}{\\rho_e} \\left( 2 E_{\\text{in}}^4 + \\frac{2}{3} \\rho_\\mu^2 \\rho_e^2 + 2 E_{\\text{in}}^2 (m_\\mu^2 + m_e^2) \\right)
```
where: 
- ``E_{\\text{in}}`` is the energy of the incoming electron/positron in CMS,
- ``\\rho_i = \\sqrt{E_{\\text{in}}^2 - m_i^2}`` are the magnitude of three-momenta of the electron (``i=e``) and muon (``i=\\mu``) in the center-of-mass frame,
- ``\\alpha`` is the fine-structure constant,
- ``m_e`` and ``m_\\mu`` are the masses of the electron and muon, respectively.

# Example 

```jldoctest
julia> E_in = 1e3 # MeV
1000.0

julia> total_cross_section(E_in)
5.576208658540326e-11

```
"""
function total_cross_section(E_in)
    #
    # FIXME: fill me in
    #
end



