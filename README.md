# 🧠 Multi-Agent Simulation with Control Barrier Functions

This repository contains a MATLAB simulation of multiple agents modeled as **double integrators** navigating in a shared space while **avoiding collisions using Control Barrier Functions (CBFs)**. The simulation is inspired by the work of Wang, Ames, and Egerstedt (2017) and implements a **quadratic program (QP)** based controller that blends nominal trajectory tracking with safety guarantees.

---

## 📌 Problem Description

Each agent \(i\) is modeled by the following second-order dynamics:

$$
\ddot{\mathbf{p}}_i = \mathbf{u}_i
$$

- \( \mathbf{p}_i \in \mathbb{R}^2 \): position  
- \( \mathbf{v}_i \in \mathbb{R}^2 \): velocity  
- \( \mathbf{u}_i \in \mathbb{R}^2 \): control input (acceleration)  

The state vector is:

$$
\mathbf{x}_i = \begin{bmatrix} \mathbf{p}_i \\ \mathbf{v}_i \end{bmatrix} \in \mathbb{R}^4
$$

State-space representation:

$$
\begin{bmatrix}\dot{\mathbf{p}}_i \\ \dot{\mathbf{v}}_i \end{bmatrix}
=
\begin{bmatrix}
\mathbf{0}  & \mathbf{I} \\
\mathbf{0}  & \mathbf{0}
\end{bmatrix}
\begin{bmatrix}\mathbf{p}_i \\ \mathbf{v}_i \end{bmatrix}
+
\begin{bmatrix}
\mathbf{0} \\
\mathbf{I}
\end{bmatrix}
\mathbf{u}_i
$$

---

## 🎯 Control Design

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
- \( \Delta \mathbf{p}_{ij} = \mathbf{p}_i - \mathbf{p}_j \)
- \( \Delta \mathbf{v}_{ij} = \mathbf{v}_i - \mathbf{v}_j \)
- \( \alpha_{sum} = \alpha_i + \alpha_j \): combined braking_

# Usage:
To run the simulation, open "Main.m" and modify the parameter "n" to set the number of agents.
