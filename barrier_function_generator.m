function barrier_function_generator(n)
% Input:  Number of robots (change n as needed)
% Ouputs: h(x) and grad_h(x) functions
fprintf('Generating barrier functions. wait...\n' )
pause(0.1)

% Define symbolic variables for positions and velocities
syms alpha_sum D_s real
p = sym('p', [2, n], 'real'); % 2D positions for n robots (p is 2 x n)
v = sym('v', [2, n], 'real'); % 2D velocities for n robots (v is 2 x n)

% Initialize barrier functions hx
hx = sym([]);

% Compute barrier functions for all robot pairs
for i = 1:n
    for j = i+1:n
        deltaP = p(:, i) - p(:, j); % Position difference
        deltaV = v(:, i) - v(:, j); % Velocity difference
        hij = sqrt(2*alpha_sum*(norm(deltaP) - D_s)) + deltaP' * deltaV / norm(deltaP); % Barrier function
        hx = [hx; hij]; % Append to hx
    end
end

% Define state vector x
x = [p(:); v(:)]; % Flatten positions and velocities into a single vector

% Compute gradient of barrier functions
grad_h = jacobian(hx, x); % Partial derivative of hx with respect to states

% system dynamics
%     B = [zeros(2*n); eye(2*n)];
%     A = [zeros(2*n) eye(2*n); zeros(2*n) zeros(2*n)];
%     f_x = A * x; % Dynamics without input
%     g_x = B; % Input matrix


% Construct numerical MATLAB function for hx
state = [x(:)]; % Flatten symbolic states into a single vector
matlabFunction(hx, 'File', 'h_calc', 'Vars', {transpose(state), alpha_sum, D_s});

matlabFunction(grad_h, 'File', 'grad_h_calc', 'Vars', {transpose(state), alpha_sum, D_s});

if isempty(which('h_calc')) || isempty(which('grad_h_calc'))
    error('Barrier functions were not generated!')
else
    fprintf(['Barrier functions were generated successfully.\n' ...
        'h(x) file name: h_calc.m\n' ...
        'grad_h(x) file name: grad_h_calc.m\n'])
end
end