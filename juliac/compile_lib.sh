unset JULIA_CPU_TARGET

jlbindir=`julia-1.12 -e 'println(dirname(Sys.BINDIR))'`


julia-1.12 --project=. $jlbindir/share/julia/juliac.jl --experimental --trim=unsafe-warn --output-lib hepexample --compile-ccallable hepexample_lib.jl

# gcc -o state_estimation_program test_juliac_library.c -I $jlbindir/include/julia/ -L$jlbindir/lib -ljulia -ldl
# gcc -o state_estimation_program test_juliac_library.c -I /opt/julia-1.12-nightly/include/julia/ -L/opt/julia-1.12-nightly/lib -ljulia -ldl
