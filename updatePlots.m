function updatePlots(plt, sct_plt, plt_title, t, xv_store, n)
r_r = 0.1;
    for i = 1:n
        set(plt(i), 'XData', xv_store(:, 2*i-1), 'YData', xv_store(:, 2*i));
%         set(sct_plt(i), 'XData', xv_store(end, 2*i-1), 'YData', xv_store(end, 2*i));
        set(sct_plt(i),'Position',[xv_store(end, 2*i-1) - r_r, xv_store(end, 2*i) - r_r, 2 * r_r, 2 * r_r])
    end
    set(plt_title, 'String', ['Time: ', num2str(t), ' s']);
    drawnow; 
end