function LegendGenerator(n)

figure('Name','Legends', ...
    'NumberTitle','off', ...
    'Position',[400 342 300 400], ...
    'MenuBar', 'none','ToolBar', 'none'); 
hold on;
box on
Color_mat = hsv(n); 

x_sample = [0 1];
y_sample = [n n];
offset = 3;
% Plot sample solid and dashed lines
for i = 1:n
    
    plot(x_sample, y_sample - i, 'Color', Color_mat(i, :), 'LineWidth', 1);
    text(1.2, y_sample(1) - i, ['$\left|\left|\,\mathbf{u}_{', num2str(i), '}^*\right|\right|$'], ...
         'Color', 'k', 'Interpreter', 'latex', 'FontSize', 12);
    
    plot(x_sample-offset, y_sample - i, 'Color', Color_mat(i, :), 'LineWidth', 1, 'LineStyle', '--');
    text(1.2-offset, y_sample(1) - i , ['$\left|\left|\,\hat{\mathbf{u}}_{', num2str(i), '}\right|\right|$'], ...
         'Color', 'k', 'Interpreter', 'latex', 'FontSize', 12);
end

% Adjust axis and aesthetics for the legend plot
set(gca, 'XTick', []); % Remove X-axis ticks
set(gca, 'YTick', []); % Remove Y-axis ticks
set(gca, 'XTickLabel', []); % Remove X-axis tick labels
set(gca, 'YTickLabel', []); % Remove Y-axis tick labels

xlim([-3.5 2.5]); % Expand x-axis range for text space
ylim([-0.05*(n-1) 1.05*(n-1)]); % Expand y-axis range for all labels
hold off;
set(gcf,'Color','White')
end