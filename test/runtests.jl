include("../src/FinNetValu.jl")

@static if VERSION < v"0.7.0-DEV.2005"
    using Base.Test
else
    using Test
end

# @testset "utils" begin
#     include("./utils/test_utils.jl")
#     include("./utils/test_nets.jl")
# end

@testset "models" begin
    # include("./models/test_csmodel.jl")
    include("./models/test_csmodel_xasCPiS.jl")
end
