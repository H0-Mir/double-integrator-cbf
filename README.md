# Multi-Agent Simulation with Control Barrier Functions

This repository contains a MATLAB simulation of multiple agents modeled as **double integrators** navigating in a shared space while **avoiding collisions using Control Barrier Functions (CBFs)**. The simulation is based on the work of Wang, Ames, and Egerstedt (2017) and implements a **quadratic program (QP)** based controller that blends nominal trajectory tracking with safety guarantees.

---

## Problem Description

Each agent \(i\) is modeled by the following second-order dynamics:

$$
\ddot{\mathbf{p}}_i = \mathbf{u}_i
$$


- $\mathbf{p}_i \in \mathbb{R}^2$: position  
- $\mathbf{v}_i \in \mathbb{R}^2$: velocity  
- $\mathbf{u}_i \in \mathbb{R}^2$: control input (acceleration)  

The state vector is:

<img width="121" height="43" alt="image" src="https://github.com/user-attachments/assets/91b80404-0aa3-4d2b-b7e8-010c827df3b1" />


State-space representation:

<img width="228" height="44" alt="image" src="https://github.com/user-attachments/assets/6d8f2f21-dd86-4bcc-8b10-c3bf34014321" />


---

## Control Design

### 1. Nominal Feedback Controller

To stabilize each agent around its desired position $\mathbf{p}_{d,i}$, a **pole-placement** method is used to design the state feedback gain $\mathbf{K} \in \mathbb{R}^{2 \times 4}$:

<img width="207" height="44" alt="image" src="https://github.com/user-attachments/assets/93f31379-3fc3-430e-9258-8a9b5988a2ab" />



The desired closed-loop poles are selected as \( [-1, -2, -1, -2] \) for smooth and stable convergence.

---

### 2. Safety with Control Barrier Functions (CBFs)

To prevent inter-agent collisions, a **pairwise safety constraint** is enforced. The CBF for each pair \( (i, j) \) is designed based on the relative dynamics and braking capability:

<img width="393" height="49" alt="image" src="https://github.com/user-attachments/assets/45e0cc58-cc25-48b7-b8ad-483d2ef9dc7d" />


Where:
- $\Delta \mathbf{p}_{ij} = \mathbf{p}_i - \mathbf{p}_j$
- $\Delta \mathbf{v}_{ij} = \mathbf{v}_i - \mathbf{v}_j$
- $\alpha_{sum} = \alpha_i + \alpha_j$: combined braking acceleration
- $D_s$: safety distance

Agents are kept in the **safe set**:

<img width="220" height="21" alt="image" src="https://github.com/user-attachments/assets/c721cd95-a33f-4072-a48b-30928b5e3659" />


The CBF condition (Lie derivative constraint) is enforced as:

$$
L_f h(x) + L_g h(x) u + \gamma h^3(x) \geq 0
$$

---

### 3. Quadratic Programming Controller

To blend **goal tracking** with **safety enforcement**, a **QP-based controller** is formulated:

<img width="282" height="78" alt="image" src="https://github.com/user-attachments/assets/5824911e-43d3-4feb-8c31-fd7710817b78" />

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
[DOI: 10.1109/TRO.2017.2659727](https://doi.org/10.1109/TRO.2017.2659727)

---

## Running the Simulation

To run the simulation, open "`Main.m`" and modify the parameter "n" to set the number of agents.
### Requirements
- MATLAB R2021+  
- Optimization Toolbox (for `quadprog`)  
- No additional toolboxes required
