function [xv_desired,xv0] = generateInitialAndDesiredPositions(n,r)

% Initial positions of robots
xy0 = [];
for theta = 0:2*pi/n:2*pi-2*pi/n
    xy0 = [xy0; round(r*cos(theta), 4); round(r*sin(theta), 4)];
end

% Desired positions (swapped)
xy_d = [];
for theta = 0:2*pi/n:2*pi-2*pi/n
    % Add pi to each initial angle to find the swapped position
    theta_d = mod(theta + pi, 2*pi); % Ensure it wraps around the circle
    xy_d = [xy_d; round(r*cos(theta_d), 4);round(r*sin(theta_d), 4)];
end

% Combine with zeros for velocities
xv0 = [xy0;zeros(2*n,1)];
xv_desired = [xy_d;zeros(2*n,1)];
end