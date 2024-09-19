function Base.isapprox(
    p1::FourMomentum,
    p2::FourMomentum;
    atol::Real=0,
    rtol::Real=Base.rtoldefault(p1.x, p1.y, atol),
    nans::Bool=false,
    norm::Function=abs,
)
    return isapprox(p1.en, p2.en; atol=atol, rtol=rtol, nans=nans, norm=norm) &&
           isapprox(p1.x, p2.x; atol=atol, rtol=rtol, nans=nans, norm=norm) &&
           isapprox(p1.y, p2.y; atol=atol, rtol=rtol, nans=nans, norm=norm) &&
           isapprox(p1.z, p2.z; atol=atol, rtol=rtol, nans=nans, norm=norm)
end
