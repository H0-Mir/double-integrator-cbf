function [plt, sct_plt, plt_title] = initializePlots(xv0, n)
Color_mat = hsv(n);
figure('Position',[675 70 850 680]);
hold on;
box on;
axis equal;
r_r = 0.1;
plt = gobjects(n, 1); % Initialize plot handle array
sct_plt = gobjects(n, 1);
for i = 1:n
    rectangle('Position', [xv0(2*i-1) - r_r, xv0(2*i) - r_r, 2 * r_r, 2 * r_r], ...
        'FaceColor',Color_mat(i, :), ...
        'EdgeColor', 'k');
    plt(i) = plot(xv0(2*i-1), xv0(2*i), '-', 'Color', Color_mat(i, :), 'LineWidth', 1);
%     sct_plt(i) = scatter(xv(2*i-1), xv(2*i),100,'filled', ...
%                 'MarkerFaceColor',Color_mat(i, :),'MarkerEdgeColor','none');
    sct_plt(i) = rectangle('Position', [xv0(2*i-1) - r_r, xv0(2*i) - r_r, 2 * r_r, 2 * r_r], ...
          'Curvature', [1, 1], ... 
          'FaceColor',Color_mat(i, :), ...
          'EdgeColor', 'k'); 
end
xlabel('x')
ylabel('y')
plt_title = title('Time: ');

end