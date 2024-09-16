struct Event{M,W}
    electron_momentum::M
    positron_momentum::M
    muon_momentum::M
    anti_muon_momentum::M

    weight::W

    # TODO: input verification
end

# TODO: overload Base.show

# construct event from momentum dict
Event(d::Dict,weight) = Event(d["e-"],d["e+"],d["mu-"],d["mu+"],weight)


