#/bin/bash

##  Must be run from same directory:
# ./make.sh && ./hepexample

set -e

julia -e 'exit(VERSION >= v"1.12" ? 0 : 1)' || (
	echo "ERROR: Need julia >= v1.12 for juliac support." >&2
	exit 1
)

(command -v juliac > /dev/null) && echo OK || (
	echo "ERROR: juliac not found on \$PATH. Please install the JuliaC app (see https://github.com/JuliaLang/juliaC.jl)" >&2
	exit 1
)

juliac --project="." --experimental --trim=safe --output-exe hepexample hepexample.jl
