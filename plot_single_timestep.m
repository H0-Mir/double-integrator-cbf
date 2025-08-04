function plot_single_timestep(n,xv_store,time_vec,time)
timestep = find(round(time_vec,1)==round(time,1));
timestep = timestep(end);
Color_mat = hsv(n);
r_r = 0.1;
figure('Position',[675 70 850 680]);
hold on;
box on;
% xlim([min(xv_store,[],'all') max(xv_store,[],'all')])
for i=1:n
    rectangle('Position', [xv_store(1,2*i-1) - r_r, xv_store(1,2*i) - r_r, 2 * r_r, 2 * r_r], ...
        'FaceColor',Color_mat(i, :), ...
        'EdgeColor', 'k');
end
axis equal
ax = axis;
axis(1.1*ax);
for i=1:n
    unvec = 0.5*(xv_store(timestep+1, 2*i-1:2*i) - xv_store(timestep, 2*i-1:2*i))/norm( xv_store(timestep+1, 2*i-1:2*i) - xv_store(timestep, 2*i-1:2*i)) ;
    arrow3(xv_store(timestep, 2*i-1:2*i),xv_store(timestep, 2*i-1:2*i)+unvec,'1',0.5,0.7)

    rectangle('Position', [xv_store(timestep, 2*i-1) - r_r, xv_store(timestep, 2*i) - r_r, 2 * r_r, 2 * r_r], ...
        'Curvature', [1, 1], ...
        'FaceColor',Color_mat(i, :), ...
        'EdgeColor', 'k');
end
xlabel('x')
ylabel('y')
title(['Time: ', num2str(round(time,1)), ' s']);
end