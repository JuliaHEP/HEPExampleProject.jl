module HEPExampleProjectPlotsExt

using HEPExampleProject
using Plots, RecipesBase

@recipe function f(event_list::AbstractVector{<:Event})
    muon_cths = muon_cos_theta.(event_list)

    @series begin
        seriestype --> :histogram

        label --> "events"
        xlabel --> "cos theta"
        ylabel := "normalized event count"
        nbins --> 100
        normalize := :pdf
        opacity --> 0.5

        (muon_cths,)
    end

    E_in = first(event_list).electron_momentum.en
    tot_weight = total_cross_section(E_in)

    @series begin
        seriestype := :line
        label := "norm. diff. CS"
        line := (2, :black, :dash)
        alpha := 0.5

        (
            range(-1,1; length=100),
            x -> differential_cross_section(E_in,x)/tot_weight*2*pi
        )
    end

end

end # module HEPExampleProjectPlotsExt
