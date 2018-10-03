d = importdata("traindata.txt"); % importoftraining data
Test = importdata("testinputs.txt"); % test data 
X = d(:,1:8); y = d(:,9); % partitioning

variables = ["x1" "x2" "x3" "x4" "x5" "na" "na" "x8"]; % negleting the features x6 and x7

N = length(X);  % 926 rows
K = 10; % folds
fold_sizes = get_fold_sizes(X, K); %function call 

max_p = 10; % max order of polynomial
results_tr = zeros(max_p + 1, 2); % results of training
results_te = zeros(max_p + 1, 2); % results of test
ws = {}; % cell to store w 

for p=0:max_p
    poly = get_polynomial(p, variables); % our model is a polynomial based on variables
    
    train_error_acc = 0; % accumulator
    test_error_acc = 0; % accumulator
    
    for k=1:K             % 1 to 10 folds      
        [X_tr, y_tr, X_te, y_te] = get_folds(X, y, fold_sizes, k); % partitioning Y
        
        Z_tr = expand(poly, X_tr); % exapnansion
        [M, R_tr, w] = least_squares(Z_tr, y_tr); % calculation of Least Sqauare
        train_error_acc = train_error_acc + R_tr; % SSE

        Z_te = expand(poly, X_te); % trying on the test
        test_error_acc = test_error_acc + sum((y_te' - w'*Z_te).^2); % SSE
    end
    results_tr(p+1, :) = [p train_error_acc/K]; % mean of SSEs
    results_te(p+1, :) = [p test_error_acc/K];  % mean of SSEs
    ws{p+1} = w;
end

p1 = plot_errors(results_tr, 'b');
hold on
p2 = plot_errors(results_te, 'r');
legend([p1 p2],{'avg R of train set','avg R of test set'}, 'Location','NorthWest');


% Find the predicted values
[min_test_err, min_test_err_idx] = min(results_te);
min_test_err_idx = min_test_err_idx(2);
min_test_err = min_test_err(2);
min_test_err_order = results_te(min_test_err_idx, 1);

sprintf("Polynomial order: %d\nMin test error  : %f", min_test_err_order, min_test_err/(N/K)) % MSE

poly = get_polynomial(min_test_err_order, variables);

Z = expand(poly, X);
y_pred = ws{min_test_err_idx}' * Z;
training_error = sum((y - y_pred').^2)/N; % MSE
sprintf("Polynomial order: %d\nTraining error  : %f", min_test_err_order, training_error)

Z = expand(poly, Test);
y_pred = ws{min_test_err_idx}' * Z;
dlmwrite('predicted_values.txt', num2str(y_pred','%.7e\t'),'delimiter', '');
