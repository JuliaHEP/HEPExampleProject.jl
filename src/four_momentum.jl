"""
    FourMomentum{T<:Real}(en::T, x::T, y::T, z::T)

Defines a four-momentum vector energy and cartesian spatial components, where the type `T` 
is a subtype of `Real`, allowing for arbitrary precision and numeric types.

# Fields

- `en`: Energy component.
- `x`: Spatial component in the x-direction.
- `y`: Spatial component in the y-direction.
- `z`: Spatial component in the z-direction.

# Example

```jldoctest
julia> p = FourMomentum(4.0, 1.0, 2.0, 3.0)
(en = 4.0, x = 1.0, y = 2.0, z = 3.0)
```
"""
struct FourMomentum{T<:Real}
    en::T  # energy component
    x::T  # x-component 
    y::T  # y-component
    z::T  # z-component
end
FourMomentum(en,x,y,z) = FourMomentum(promote(en,x,y,z)...)

# Overload Base.show for pretty printing of FourMomentum
function Base.show(io::IO, p::FourMomentum)
    println(io, "(en = $(p.en), x = $(p.x), y = $(p.y), z = $(p.z))")
end



"""

    Base.:+(p1::FourMomentum,p2::FourMomentum) 

Defines vector addition for two `FourMomentum` objects. The result is a new `FourMomentum` 
with each component being the sum of the corresponding components of `p1` and `p2`.

# Example

```julia
julia> p1 = FourMomentum(4.0, 1.0, 2.0, 3.0)
julia> p2 = FourMomentum(2.0, 0.5, 1.0, 1.5)
julia> p1 + p2
(en = 6.0, x = 1.5, y = 3.0, z = 4.5)
```
"""
function Base.:+(p1::FourMomentum, p2::FourMomentum) 
    FourMomentum(p1.en + p2.en, p1.x + p2.x, p1.y + p2.y, p1.z + p2.z)
end


"""
    
    Base.:-(p1::FourMomentum,p2::FourMomentum) 

Defines vector subtraction for two `FourMomentum` objects. The result is a new `FourMomentum` 
with each component being the difference between the corresponding components of `p1` and `p2`.

# Example

```jldoctest
julia> p1 = FourMomentum(4.0, 1.0, 2.0, 3.0)
julia> p2 = FourMomentum(2.0, 0.5, 1.0, 1.5)
julia> p1 - p2
(en = 2.0, x = 0.5, y = 1.0, z = 1.5)
```
""" 
function Base.:-(p1::FourMomentum, p2::FourMomentum) 
    FourMomentum(p1.en - p2.en, p1.x - p2.x, p1.y - p2.y, p1.z - p2.z)
end


"""
    
    Base.:*(a::Real,p2::FourMomentum) 

Defines scalar multiplication for a `FourMomentum` object, scaling each component of the 
four-momentum by a scalar `a`.

# Example

```jldoctest
julia> p = FourMomentum(4.0, 1.0, 2.0, 3.0)
julia> 2 * p
(en = 8.0, x = 2.0, y = 4.0, z = 6.0)
```
"""
function Base.:*(a::Real, p::FourMomentum) 
    FourMomentum(a * p.en, a * p.x, a * p.y, a * p.z)
end


"""

    minkowski_dot(p1::FourMomentum, p2::FourMomentum)

Computes the Minkowski dot product of two four-momentum vectors. The dot product uses the 
Minkowski metric `(+,-,-,-)`. For ``p_i = (E_i,p_i^x,p_i^y,p_i^z)`` with ``i=1,2``, the result is:

```math
    p_1 \\cdot p_2 = E_1E_2 - p_1^xp_2^x - p_1^yp_2^y + p_1^zp_2^z
```

# Example
```jldoctest
julia> p1 = FourMomentum(4.0, 1.0, 2.0, 3.0)
julia> p2 = FourMomentum(3.0, 0.5, 1.0, 1.5)
julia> minkowski_dot(p1, p2)
9.75
```
"""
function minkowski_dot(p1::FourMomentum, p2::FourMomentum)
    # Minkowski metric: (+,-,-,-)
    return p1.en * p2.en - p1.x * p2.x - p1.y * p2.y - p1.z * p2.z
end

# constructs momenta from coordinates
function _construct_from_coords(E_in,cos_theta,phi)
    rho_e = _rho(E_in,ELECTRON_MASS)
    p_in_electron = FourMomentum(E_in,0,0,rho_e)
    p_in_positron = FourMomentum(E_in,0,0,-rho_e)

    
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
