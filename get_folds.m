function [X_tr, y_tr, X_te, y_te] = get_folds(X, y, fold_sizes, k)
    % This functios returns the folds for the training set and test set
    N = length(X);
    i_start = sum(fold_sizes(1:k-1)) + 1; %start index of training set
    i_end = i_start + fold_sizes(k) - 1; % end index of test set

    X_tr = X([1:i_start-1 i_end+1:N], :);  % Xtraining set
    y_tr = y([1:i_start-1 i_end+1:N], :); % y training set
    X_te = X(i_start:i_end, :); % xtest set
    y_te = y(i_start:i_end, :); %ytest set
end
