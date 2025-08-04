function PerformancePlots(n,h_store,xv_store,ustar_store,udes_store,time_vec)
Color_mat = hsv(n);
figure('Position', [20, 70, 650, 680]);
subplot(3,1,1)
hold on;
box on;
% Extract max and min values of each row of h_store
max_values = max(h_store, [], 2); % Max values for each row
min_values = min(h_store, [], 2); % Min values for each row

% Ensure time_vec matches the dimensions
time_vec_modif = time_vec(1:size(h_store, 1));

% Plot the maximum and minimum lines
plot(time_vec_modif, max_values, 'k--', 'LineWidth', 1);
plot(time_vec_modif, min_values, 'k--', 'LineWidth', 1);
% plot(time_vec,h_store,'k')
% Fill the area between max and min
fill([time_vec_modif; flipud(time_vec_modif)]', ...
    [max_values; flipud(min_values)]', ...
    'k', 'FaceAlpha', 0.2, 'EdgeColor', 'none');

ylabel('Barrier functions range')
xlabel('time (s)')
xlim([0 time_vec_modif(end)])
hold off;
%%
subplot(3,1,2)
hold on;
box on;
xlim([0 time_vec_modif(end)])
for i=n+1:2*n
    plot(time_vec_modif,sqrt(sum(xv_store(1:end-1,2*i-1:2*i).^2,2)),'Color',Color_mat(i-n,:),'LineWidth',1)
end
ylabel('Agents'' speeds')
xlabel('time (s)')
%%
subplot(3,1,3)
hold on;
box on;
xlim([0 time_vec_modif(end)])
for i=1:n
    plot(time_vec_modif,sqrt(sum(ustar_store(:,2*i-1:2*i).^2,2)),'Color',Color_mat(i,:),'LineWidth',1)
end
for i=1:n
    plot(time_vec_modif,sqrt(sum(udes_store(:,2*i-1:2*i).^2,2)),'Color',Color_mat(i,:),'LineWidth',1,'LineStyle','--')
end
hold off;
% lgd = legend;
% for i=1:n
%     lgd.String(i) = {append('$\left|\left|\,\mathbf{u}_' ,num2str(i), '^*\right|\right|$')};
% end
% for i=n+1:2*n
%     lgd.String(i) = {append('$\left|\left|\,\hat\mathbf{u}_' ,num2str(i-n), '\right|\right|$')};
% end
% lgd.NumColumns = 2;
ylabel('Control inputs')
xlabel('time (s)')
end
