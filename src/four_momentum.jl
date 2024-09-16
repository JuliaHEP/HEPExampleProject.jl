# Define the FourMomentum type
struct FourMomentum{T<:Real}
    en::T  # energy component
    x::T  # x-component 
    y::T  # y-component
    z::T  # z-component
end
FourMomentum(en,x,y,z) = FourMomentum(promote(en,x,y,z)...)

# Overload Base.show for better display of FourMomentum
function Base.show(io::IO, p::FourMomentum)
    println(io, "FourMomentum: (en = $(p.en), x = $(p.x), y = $(p.y), z = $(p.z))")
end

# Vector addition: p1 + p2
function Base.:+(p1::FourMomentum, p2::FourMomentum) 
    FourMomentum(p1.en + p2.en, p1.x + p2.x, p1.y + p2.y, p1.z + p2.z)
end

# Vector substraction: p1 - p2
function Base.:-(p1::FourMomentum, p2::FourMomentum) 
    FourMomentum(p1.en - p2.en, p1.x - p2.x, p1.y - p2.y, p1.z - p2.z)
end

# Scalar multiplication: a * p
function Base.:*(a::Real, p::FourMomentum) 
    FourMomentum(a * p.en, a * p.x, a * p.y, a * p.z)
end

# Minkowski dot product: p ⋅ p
function minkowski_dot(p1::FourMomentum, p2::FourMomentum)
    # Minkowski metric: (+,-,-,-)
    return p1.en * p2.en - p1.x * p2.x - p1.y * p2.y - p1.z * p2.z
end

# constructs momenta from coordinates
function _construct_from_coords(E_in,cos_theta,phi)
    rho_e = _rho(E_in,ELECTRON_MASS)
    p_in_electron = FourMomentum(E_in,0,0,rho_e)
    p_in_positron = FourMomentum(E_in,0,0,rho_e)

    
    rho_mu = _rho(E_in,MUON_MASS)
    sin_theta = sqrt(1-cos_theta^2)
    sin_phi,cos_phi = sincos(phi)
    p_out_muon = FourMomentum(E_in,
                              rho_mu*sin_theta*cos_phi,
                              rho_mu*sin_theta*sin_phi,
                              rho_mu*cos_theta
                              )
    p_out_anti_muon = p_in_electron + p_in_positron - p_out_muon

    return Dict(
        "e-" => p_in_electron,
        "e+" => p_in_positron,
        "mu-" => p_out_muon,
        "mu+" => p_out_anti_muon
    )
end
