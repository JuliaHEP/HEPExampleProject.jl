module HEPExampleProjectMakieExt

using HEPExampleProject
using Makie
using Makie: SpecApi as SpecApi


function Makie.convert_arguments(::Type{<:AbstractPlot}, event_list::AbstractVector{<:Event})
    plots = PlotSpec[]

    muon_cths = muon_cos_theta.(event_list)
    push!(
        plots,
        SpecApi.Hist(
            muon_cths,
            label = "events",
            bins = 100,
            normalization = :pdf,
        )
    )


    E_in = first(event_list).electron_momentum.en
    tot_weight = total_cross_section(E_in)

    push!(
        plots,
        SpecApi.Lines(
            range(-1,1; length=100),
            x -> differential_cross_section(E_in,x)/tot_weight*2*pi,
            label = "norm. diff. CS",
            linestyle = :dash,
            color = :black,
            linewidth = 2,
            alpha = 0.5
        )
    )

    return plots
end

end # module HEPExampleProjectMakieExt
