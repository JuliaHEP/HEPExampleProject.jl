using HEPExampleProject
using Documenter

DocMeta.setdocmeta!(HEPExampleProject, :DocTestSetup, :(using HEPExampleProject); recursive=true)

makedocs(;
    modules=[HEPExampleProject],
    authors="Uwe Hernandez Acosta <u.hernandez@hzdr.de>",
    sitename="HEPExampleProject.jl",
    format=Documenter.HTML(;
        canonical="https://JuliaHEP.github.io/HEPExampleProject.jl",
        edit_link="main",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
    ],
)

deploydocs(;
    repo="github.com/JuliaHEP/HEPExampleProject.jl",
    devbranch="main",
)
