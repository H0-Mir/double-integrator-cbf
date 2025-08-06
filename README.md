# Multi-Agent Simulation with Control Barrier Functions

This repository contains a MATLAB simulation of multiple agents modeled as **double integrators** navigating in a shared space while **avoiding collisions using Control Barrier Functions (CBFs)**. The simulation is based on the work of Wang, Ames, and Egerstedt (2017) and implements a **quadratic program (QP)** based controller that blends nominal trajectory tracking with safety guarantees.

---

## Problem Description

Each agent \(i\) is modeled by the following second-order dynamics:

$$
\ddot{\mathbf{p}}_i = \mathbf{u}_i
$$
<img width="100" height="33" alt="image" src="https://github.com/user-attachments/assets/fff29b85-25db-4420-bb65-8fc2ff834fbc" />

- $\mathbf{p}_i \in \mathbb{R}^2$: position  
- $\mathbf{v}_i \in \mathbb{R}^2$: velocity  
- $\mathbf{u}_i \in \mathbb{R}^2$: control input (acceleration)  

The state vector is:

$$
\mathbf{x}_i = \begin{bmatrix} \mathbf{p}_i \\ \mathbf{v}_i \end{bmatrix} \in \mathbb{R}^4
$$

State-space representation:
    [ ṗ_i ; v̇_i ] = [ 0  I ; 0  0 ] [ p_i ; v_i ] + [ 0 ; I ] u_i

---

## Control Design

### 1. Nominal Feedback Controller

To stabilize each agent around its desired position \( \mathbf{p}_{d,i} \), a **pole-placement** method is used to design the state feedback gain \( \mathbf{K} \in \mathbb{R}^{2 \times 4} \):

$$
\mathbf{u}_i = -\mathbf{K} \left(
\begin{bmatrix} \mathbf{p}_i \\ \mathbf{v}_i \end{bmatrix} -
\begin{bmatrix} \mathbf{p}_{d,i} \\ \mathbf{0} \end{bmatrix}
\right)
$$

The desired closed-loop poles are selected as \( [-1, -2, -1, -2] \) for smooth and stable convergence.

---

### 2. Safety with Control Barrier Functions (CBFs)

To prevent inter-agent collisions, a **pairwise safety constraint** is enforced. The CBF for each pair \( (i, j) \) is designed based on the relative dynamics and braking capability:

$$
h_{ij}(\mathbf{p}, \mathbf{v}) =
\sqrt{2\alpha_{sum}(\|\Delta \mathbf{p}_{ij}\| - D_s)} +
\frac{\Delta \mathbf{p}_{ij}^\top}{\|\Delta \mathbf{p}_{ij}\|} \Delta \mathbf{v}_{ij}
$$

Where:
- $\Delta \mathbf{p}_{ij} = \mathbf{p}_i - \mathbf{p}_j$
- $\Delta \mathbf{v}_{ij} = \mathbf{v}_i - \mathbf{v}_j$
- $\alpha_{sum} = \alpha_i + \alpha_j$: combined braking acceleration
- $D_s$: safety distance

Agents are kept in the **safe set**:

$$
\mathcal{C} = \{\mathbf{x} \in \mathbb{R}^4 \mid h_{ij}(\mathbf{p}, \mathbf{v}) \geq 0 \}
$$

The CBF condition (Lie derivative constraint) is enforced as:

$$
L_f h(x) + L_g h(x) u + \gamma h^3(x) \geq 0
$$

---

### 3. Quadratic Programming Controller

To blend **goal tracking** with **safety enforcement**, a **QP-based controller** is formulated:

$$
\begin{aligned}
\mathbf{u}^* = \underset{\mathbf{u} \in \mathbb{R}^{2n}}{\operatorname{argmin}} \quad & \sum_{i=1}^N \|\mathbf{u}_i - \hat{\mathbf{u}}_i\|^2 \\
\text{subject to} \quad & \mathbf{A}_{ij} \mathbf{u}_i \leq \mathbf{b}_{ij}, \quad \forall i \neq j
\end{aligned}
$$

Where:
- $\hat{\mathbf{u}}_i$: nominal control from the feedback controller
- $\mathbf{A}_{ij} = -L_g h(x)$
- $\mathbf{b}_{ij} = L_f h(x) + \gamma h^3(x)$

This formulation ensures **minimal deviation from the nominal control** while satisfying all **safety constraints**.

---

## Reference

Wang, L., Ames, A. D., & Egerstedt, M. (2017).  
“**Safety barrier certificates for collision-free multi-robot systems**,”  
*IEEE Transactions on Robotics*, 33(3), 661–674.  
[doi:10.1109/TRO.2017.2659727](https://doi.org/10.1109/TRO.2017.2659727)

---

## Running the Simulation

To run the simulation, open "`Main.m`" and modify the parameter "n" to set the number of agents.
### Requirements
- MATLAB R2021+  
- Optimization Toolbox (for `quadprog`)  
- No additional toolboxes required
