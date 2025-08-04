function LegendGenerator2(n)

figure('Name','Legends', ...
    'NumberTitle','off', ...
    'Position',[488 342 300 400], ...
    'MenuBar', 'none','ToolBar', 'none'); 
hold on;
box on
Color_mat = hsv(n); 

for i = 1:n
    
    scatter(0, n - i,200,'MarkerFaceColor', Color_mat(i, :), ...
        'MarkerEdgeColor', 'k', ...
        'Marker','square', 'LineWidth', 1 );
    text(0.5, n - i, ['Agent ', num2str(i), ''], ...
         'Color', 'k', 'Interpreter', 'latex', 'FontSize', 12);

end

% Adjust axis and aesthetics for the legend plot
set(gca, 'XTick', []); % Remove X-axis ticks
set(gca, 'YTick', []); % Remove Y-axis ticks
set(gca, 'XTickLabel', []); % Remove X-axis tick labels
set(gca, 'YTickLabel', []); % Remove Y-axis tick labels

xlim([-1.5 2.5]); % Expand x-axis range for text space
ylim([-0.05*(n-1) 1.05*(n-1)]); % Expand y-axis range for all labels
hold off;
set(gcf,'Color','White')
end