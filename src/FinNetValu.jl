module FinNetValu

include("utils/utils.jl")
include("utils/nets.jl")
include("models/model.jl")
include("models/neva.jl")
include("models/xos.jl")
# include("models/csmodel.jl")
include("models/csmodel_xasCPiS.jl")
include("pricing/bs.jl")
include("pricing/mc.jl")

# Generic financial model interface
export fixvalue, fixjacobian, valuation!, valuation, solvent, numfirms
# Model constructors
export XOSModel, NEVAModel, EisenbergNoeModel, FurfineModel, LinearDebtRankModel, CSModel
# Model specifics
export bookequity, equityview, debtview, delevprop, marketimpact, marketdepth,
        illiquid

# Pricing helpers
export BlackScholesParams, Aτ, discount
# Monte-Carlo helpers
export MonteCarloSampler, sample, expectation

# Functional utils
export constantly, calm
# Network utils
export erdosrenyi, rescale, barabasialbert


end # module
