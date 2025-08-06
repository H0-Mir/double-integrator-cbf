clc; clear; close all;

n = 6; % Number of agents

%% Safety Barrier function generator
%%% If the correct "h_calc.m" and "grad_h_calc.m" files are missing,  
%%% uncomment the line below.  
% barrier_function_generator(n)

%% Parameters

% State-space dynamics
A = [zeros(2*n), eye(2*n); zeros(2*n), zeros(2*n)];
B = [zeros(2*n); eye(2*n)];

% Constraint Parameters
alpha_sum = 20;
D_s = 1;
gamma = 0.1;

% Simulation Parameters
t_f = 20;   % Final time
dt = 0.1;   % Time step

K = place(A, B, repmat([-1 -2], 1, 2*n));  % Stabilizing gain 

[xv_desired,xv0] = generateInitialAndDesiredPositions(n,5);

xv_desired(1:2*n) = xv_desired(1:2*n);% + -0.1+0.2*rand(2*n,1);

%% Initialize the figure and subplots
[plt, sct_plt, plt_title] = initializePlots(xv0, n);
LegendGenerator2(n)

%% Real-time simulation and plotting
fprintf('Starting Simulation for %d agents...\n',n)
xv_store = xv0';
time_vec = 0;
h_store = [];
ustar_store = [];
udes_store = [];
exitflag_store = [];
tic
for t = 0:dt:t_f
    u_des = nominal_controller(xv_desired, xv_store(end, :)', K); % Compute desired u
    [u_star,h,exitflag] = ...               % Modify u using Safety Barrier
        SafetyBarrier(n,A,B,u_des,xv_store(end, :)',alpha_sum,D_s,gamma);
    %%%%%%%%%%%%%%%% uncomment to Deadlock prevention %%%%%%%%%%%%%%%%
%     for i=1:n
%         if norm(u_des(2*i-1:2*i))>0.1 && norm(u_star(2*i-1:2*i))<0.1 && norm(xv_store(end, n+2*i-1:n+2*i)') < 1
%             u_star(2*i-1:2*i) = [0 -1;1 0]*u_des(2*i-1:2*i); 
%             disp([t i])
%         end
%     end
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    [~, xv_temp] =  ...                     % Numerical solve
        ode45(@(t, xv) agents_dynamics(t, xv, u_star, A, B), [t t+dt], xv_store(end, :)'); 
    xv_store = [xv_store; xv_temp(end, :)]; % Store only the last state
    time_vec = [time_vec; t + dt];          % Update time vector
    h_store = [h_store; h'];                % Update h matrix
    ustar_store = [ustar_store; u_star'];   % Update u_star matrix
    udes_store = [udes_store; u_des'];      % Update u_des matrix
    exitflag_store = [exitflag_store;exitflag]; % Store exit flags
    updatePlots(plt, sct_plt, plt_title, t, xv_store, n); % Update plots
%     pause(dt)
end
toc
if ~isempty(find(~(exitflag_store==1), 1))
    fprintf('QP has not converged to a solution for some u*, Results may not be valid.\n')
end
fprintf('Simulation ended.\n')
%%
PerformancePlots(n,h_store,xv_store,ustar_store,udes_store,time_vec)
LegendGenerator(n)

% The command below can be used to view the positions of agents and their
% velocity vectors at a specific 'time'.
% Example Command:   plot_single_timestep(n,xv_store,time_vec,3)


