module PlottingExt

using HEPExampleProject
using StatsPlots


function HEPExampleProject.plot_muon_cos_theta(event_list; kwargs...)
    E_in = event_list[1].electron_momentum.en
    muon_cths = muon_cos_theta.(event_list)
    P = histogram(muon_cths;
        label="events",
        xlabel="cos theta",
        ylabel="normalized event count",
        nbins=100,
        normalize=:pdf,
        opacity=0.5,
        kwargs...
    )

    tot_weight = total_cross_section(E_in)
    plot!(P, range(-1,1; length=100), x -> differential_cross_section(E_in,x)/tot_weight*2*pi;
        label="norm. diff. CS",
        line=(2, :black, :dash),
        alpha=0.5
    )

    return P
end

end
