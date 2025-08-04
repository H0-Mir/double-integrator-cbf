function xv_dot = agents_dynamics(~, xv, u, A, B)
    xv_dot = A * xv + B * u; % State-space dynamics
end
