function [u,h,exitflag] = ...
SafetyBarrier(n, state_matrix, input_matrix, ...
             u_des, state_vector, alpha_sum, D_s, gamma)


g_x = input_matrix;
f_x = state_matrix*state_vector;

h = h_calc(reshape(state_vector,[],4*n),alpha_sum,D_s);
grad_h = grad_h_calc(reshape(state_vector,[],4*n),alpha_sum,D_s);


H = 2*eye(2*n);
f = -2*u_des;
A = -(grad_h*g_x);
b = grad_h*f_x + gamma*h.^3;

% Fmincon
% u_d = u_des;
% options = optimoptions('fmincon','Display','off','Algorithm','sqp');   
% fun = @(u) (u - u_d)'*eye(2*n)*(u - u_d);
%  [u_opt,~,exitflag]  = fmincon(fun,u_d,real(A),real(b),[],[],[],[],[],options);

% quadprog
x0 = u_des;
lb = -20*ones(2*n,1);
ub = 20*ones(2*n,1);
% lb = [];
% ub = [];
options = optimoptions('quadprog','Algorithm','active-set','Display','off');
[u_opt,~,exitflag] = quadprog(H,f,real(A),real(b),[],[],lb,ub,x0,options);


 
% Return variables
u = u_opt;
    
end