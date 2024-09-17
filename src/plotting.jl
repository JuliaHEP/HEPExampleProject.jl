function plot_compare(event_coord_list, weight_fct,lower,upper; kwargs...)
    P = histogram(event_coord_list;
        label="Sampled density",
        xlabel="x",
        ylabel="pdf(x)",
        nbins=100,
        normalize=:pdf,
        opacity=0.5,
        kwargs...
    )

    tot_weight,_ = quadgk(weight_fct,lower,upper)
    plot!(P, range(lower,upper; length=100), t -> weight_fct(t)/tot_weight;
        label="True density",
        line=(2, :black, :dash),
        alpha=0.5
    )

    return P
end