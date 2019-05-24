"""
sanity check, manually computing iterations of fire sales of two bank example
"""
using Plots
pyplot()


Π_0 = hcat([90.; 70.])
Θ = [10. 0.; 0. 20.]
C = [4., 4.5]
λ_max = 33.3
λ_target = 0.95*λ_max
S_0 = [1.]
B = [0.5*S_0[1]]
ADV = [50.]
σ = [0.02]
c = 0.4
τ = 20.
α = 0.5

#------------------------------------------------------------------------------#
# ϵ_1 = [0.05, 0.0]
#------------------------------------------------------------------------------#
ϵ_1 = [0.05, 0.0]

I_ϵ = [sum(Θ[i,:]) - sum(ϵ_1.*Θ[i,:]) for i in 1:size(Θ,1)]
C_ϵ = [max(C[i] - sum(ϵ_1.*Θ[i,:]), 0) for i in 1:size(C,1)]
C_0 = copy(C_ϵ)

D = c*(ADV/σ)*sqrt(τ)
δ = (1. -(B[1]/S_0[1]))*D

λ = [(Π_0[i,1] + I_ϵ[i])/C_ϵ[i] for i in 1:size(Π_0,1)]

λ .> λ_max

Γ_1 = [0. 0.]

Π_1 = Π_0
C_1 = C_0
S_1 = S_0

#------------------------------------------------------------------------------#
# ϵ_2 = [0.2, 0.0]
#------------------------------------------------------------------------------#
ϵ_2 = [0.2, 0.0]

I_ϵ = [sum(Θ[i,:]) - sum(ϵ_2.*Θ[i,:]) for i in 1:size(Θ,1)]
C_ϵ = [max(C[i] - sum(ϵ_2.*Θ[i,:]), 0) for i in 1:size(C,1)]
C_0 = copy(C_ϵ)

D = c*(ADV/σ)*sqrt(τ)
δ = (1. -(B[1]/S_0[1]))*D

#----------------------------
# round 1

λ_1 = [(Π_0[i,1] + I_ϵ[i])/C_ϵ[i] for i in 1:size(Π_0,1)]

Γ_1 = abs.((Π_0 .+ I_ϵ .- λ_target*C_ϵ)./Π_0 .* (λ_1 .> λ_max))

q_1 = sum(Γ_1 .* Π_0)
Ψ_1 = (1. - B[1]/S_0[1])*(1. - exp(-q_1/δ[1]))

S_1 = S_0 *(1. - Ψ_1)

Π_1 = (1. .- Γ_1) .* Π_0 .* (1. - Ψ_1)

L_1 = (1. .- (1. - α) .* Γ_1) .* Π_0 .* Ψ_1
C_1 = C_0 .- L_1

#----------------------------
# round 2
λ_2 = [(Π_1[i,1] + I_ϵ[i])/C_1[i] for i in 1:size(Π_0,1)]

Γ_2 = abs.((Π_1 .+ I_ϵ .- λ_target*C_1)./Π_1 .* (λ_2 .> λ_max))

q_2 = sum(Γ_2 .* Π_1)
Ψ_2 = (1. - B[1]/S_1[1])*(1. - exp(-q_2/δ[1]))

S_2 = S_1 *(1. - Ψ_2)

Π_2 = (1. .- Γ_2) .* Π_1 .* (1. - Ψ_2)

L_2 = (1. .- (1. - α) .* Γ_2) .* Π_1 .* Ψ_2
C_2 = C_1 .- L_2

#----------------------------
# round 3
λ_3 = [(Π_2[i,1] + I_ϵ[i])/C_2[i] for i in 1:size(Π_0,1)]

Γ_3 = abs.((Π_2 .+ I_ϵ .- λ_target*C_2)./Π_2 .* (λ_3 .> λ_max))

q_3 = sum(Γ_3 .* Π_2)
Ψ_3 = (1. - B[1]/S_2[1])*(1. - exp(-q_3/δ[1]))

S_3 = S_2 *(1. - Ψ_3)

Π_3 = (1. .- Γ_3) .* Π_2 .* (1. - Ψ_3)

L_3 = (1. .- (1. - α) .* Γ_3) .* Π_2 .* Ψ_3
C_3 = C_2 .- L_3

#----------------------------
# round 4
λ_4 = [(Π_3[i,1] + I_ϵ[i])/C_3[i] for i in 1:size(Π_0,1)]

Γ_4 = abs.((Π_3 .+ I_ϵ .- λ_target*C_3)./Π_3 .* (λ_4 .> λ_max))

q_4 = sum(Γ_4 .* Π_3)
Ψ_4 = (1. - B[1]/S_3[1])*(1. - exp(-q_4/δ[1]))

S_4 = S_3 *(1. - Ψ_4)

Π_4 = (1. .- Γ_4) .* Π_3 .* (1. - Ψ_4)

L_4 = (1. .- (1. - α) .* Γ_4) .* Π_3 .* Ψ_4
C_4 = C_3 .- L_4

#----------------------------
# round 5
λ_5 = [(Π_4[i,1] + I_ϵ[i])/C_4[i] for i in 1:size(Π_0,1)]

Γ_5 = abs.((Π_4 .+ I_ϵ .- λ_target*C_4)./Π_4 .* (λ_5 .> λ_max))

q_5 = sum(Γ_5 .* Π_4)
Ψ_5 = (1. - B[1]/S_4[1])*(1. - exp(-q_5/δ[1]))

S_5 = S_4 *(1. - Ψ_5)

Π_5 = (1. .- Γ_5) .* Π_4 .* (1. - Ψ_5)

L_5 = (1. .- (1. - α) .* Γ_5) .* Π_4 .* Ψ_5
C_5 = C_4 .- L_5

#----------------------------
# plot results
p1 = scatter(ones(5), [Γ_1[1], Γ_2[1], Γ_3[1], Γ_4[1], Γ_5[1]])
p1 = scatter(ones(5), [Γ_1[2], Γ_2[2], Γ_3[2], Γ_4[2], Γ_5[2]])

p1 = scatter(ones(5), [L_1[2], L_2[2], L_3[2], L_4[2], L_5[2]])

#------------------------------------------------------------------------------#
# ϵ_3 = [0.25, 0.0]
#------------------------------------------------------------------------------#
ϵ_3 = [0.25, 0.0]

I_ϵ = [sum(Θ[i,:]) - sum(ϵ_3.*Θ[i,:]) for i in 1:size(Θ,1)]
C_ϵ = [max(C[i] - sum(ϵ_3.*Θ[i,:]), 0) for i in 1:size(C,1)]
C_0 = copy(C_ϵ)

D = c*(ADV/σ)*sqrt(τ)
δ = (1. -(B[1]/S_0[1]))*D

#----------------------------
# round 1

λ_1 = [(Π_0[i,1] + I_ϵ[i])/C_ϵ[i] for i in 1:size(Π_0,1)]

Γ_1 = abs.((Π_0 .+ I_ϵ .- λ_target*C_ϵ)./Π_0 .* (λ_1 .> λ_max))

q_1 = sum(Γ_1 .* Π_0)
Ψ_1 = (1. - B[1]/S_0[1])*(1. - exp(-q_1/δ[1]))

S_1 = S_0 *(1. - Ψ_1)

Π_1 = (1. .- Γ_1) .* Π_0 .* (1. - Ψ_1)

L_1 = (1. .- (1. - α) .* Γ_1) .* Π_0 .* Ψ_1
C_1 = C_0 .- L_1

#----------------------------
# round 2
λ_2 = [(Π_1[i,1] + I_ϵ[i])/C_1[i] for i in 1:size(Π_0,1)]

Γ_2 = abs.((Π_1 .+ I_ϵ .- λ_target*C_1)./Π_1 .* (λ_2 .> λ_max))

q_2 = sum(Γ_2 .* Π_1)
Ψ_2 = (1. - B[1]/S_1[1])*(1. - exp(-q_2/δ[1]))

S_2 = S_1 *(1. - Ψ_2)

Π_2 = (1. .- Γ_2) .* Π_1 .* (1. - Ψ_2)

L_2 = (1. .- (1. - α) .* Γ_2) .* Π_1 .* Ψ_2
C_2 = C_1 .- L_2

#----------------------------
# round 3
λ_3 = [(Π_2[i,1] + I_ϵ[i])/C_2[i] for i in 1:size(Π_0,1)]

Γ_3 = abs.((Π_2 .+ I_ϵ .- λ_target*C_2)./Π_2 .* (λ_3 .> λ_max))

q_3 = sum(Γ_3 .* Π_2)
Ψ_3 = (1. - B[1]/S_2[1])*(1. - exp(-q_3/δ[1]))

S_3 = S_2 *(1. - Ψ_3)

Π_3 = (1. .- Γ_3) .* Π_2 .* (1. - Ψ_3)

L_3 = (1. .- (1. - α) .* Γ_3) .* Π_2 .* Ψ_3
C_3 = C_2 .- L_3

#----------------------------
# round 4
λ_4 = [(Π_3[i,1] + I_ϵ[i])/C_3[i] for i in 1:size(Π_0,1)]

Γ_4 = abs.((Π_3 .+ I_ϵ .- λ_target*C_3)./Π_3 .* (λ_4 .> λ_max))

q_4 = sum(Γ_4 .* Π_3)
Ψ_4 = (1. - B[1]/S_3[1])*(1. - exp(-q_4/δ[1]))

S_4 = S_3 *(1. - Ψ_4)

Π_4 = (1. .- Γ_4) .* Π_3 .* (1. - Ψ_4)

L_4 = (1. .- (1. - α) .* Γ_4) .* Π_3 .* Ψ_4
C_4 = C_3 .- L_4

#----------------------------
# round 5
λ_5 = [(Π_4[i,1] + I_ϵ[i])/C_4[i] for i in 1:size(Π_0,1)]

Γ_5 = abs.((Π_4 .+ I_ϵ .- λ_target*C_4)./Π_4 .* (λ_5 .> λ_max))

q_5 = sum(Γ_5 .* Π_4)
Ψ_5 = (1. - B[1]/S_4[1])*(1. - exp(-q_5/δ[1]))

S_5 = S_4 *(1. - Ψ_5)

Π_5 = (1. .- Γ_5) .* Π_4 .* (1. - Ψ_5)

L_5 = (1. .- (1. - α) .* Γ_5) .* Π_4 .* Ψ_5
C_5 = C_4 .- L_5

#----------------------------
# plot results
p1 = scatter(ones(5), [Γ_1[1], Γ_2[1], Γ_3[1], Γ_4[1], Γ_5[1]],
                c=["blue"; "red"; "green"; "purple"; "yellow"])
p1 = scatter(ones(5), [Γ_1[2], Γ_2[2], Γ_3[2], Γ_4[2], Γ_5[2]])

p1 = scatter(ones(5), [L_1[2], L_2[2], L_3[2], L_4[2], L_5[2]])