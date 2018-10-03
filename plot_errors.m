function [p] = plot_errors(results, color)
    % results input argument is a Mx2 matrix:
    % col 1: polynomial orders
    % col 2: R ( Sum of Square Error)
    title('Average error vs degree of polynomial')
    xlabel('degree of polynomial')
    ylabel('R')
    
    scatter(results(:,1), results(:,2), '*', color); hold on
    for i=1:length(results)-1
        p = plot([results(i,1) results(i+1,1)], [results(i,2) results(i+1,2)], color);
    end
    ylim([0.0 100000.0]);
end
