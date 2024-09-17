
@inline _rho(E,m) = sqrt(E^2 - m^2) 

"""
TBW
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



