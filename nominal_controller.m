function u = nominal_controller(xv_d, xv, K)
    u = -K * (xv - xv_d); % Feedback control law
end