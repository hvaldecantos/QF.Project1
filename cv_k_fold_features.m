d = importdata("traindata.txt"); %train data
Test = importdata("testinputs.txt");% test data
X = d(:,1:8); y = d(:,9);

variables = ["x1" "x2" "x3" "x4" "x5" "x6" "x7" "x8"]; %all features considered
all_combinations = get_combination(variables); %all possible combination of features

N = length(X); 
K = 10; %fold size
fold_sizes = get_fold_sizes(X, K); %array of sizes of each fold

max_p = 10; %max order of polynomial
results_tr = zeros((max_p + 1)*length(all_combinations), 2); % training results
results_te = zeros((max_p + 1)*length(all_combinations), 2); % test results
ws = {}; %cell to store w's
vars = {}; % cell to store arrangemrnt of variables

idx = 1; %start index


for v=1:length(all_combinations)
    for p=0:max_p
        variables = all_combinations(v,:);
        
        poly = get_polynomial(p, variables);

        train_error_acc = 0; %training accumulator error
        test_error_acc = 0; %test accumulator error

        for k=1:K
            [X_tr, y_tr, X_te, y_te] = get_folds(X, y, fold_sizes, k); %current fold for k

            Z_tr = expand(poly, X_tr); %Z matrix for training set
            [M, R_tr, w] = least_squares(Z_tr, y_tr); % least square
            train_error_acc = train_error_acc + R_tr; % SSE

            Z_te = expand(poly, X_te); %Zmatrix for test set
            test_error_acc = test_error_acc + sum((y_te' - w'*Z_te).^2); % SSE
        end
        results_tr(idx, :) = [p train_error_acc/K]; % mean of SSEs
        results_te(idx, :) = [p test_error_acc/K];  % mean of SSEs
        ws{idx} = w; %storing in ws
        vars{idx} = variables; % storing variables arrangement
        idx = idx + 1;
    end
end

% Find the predicted values
[min_test_err, min_test_err_idx] = min(results_te); % min of test error with index
min_test_err_idx = min_test_err_idx(2); % fetching the index
min_test_err = min_test_err(2); %fetching the value
min_test_err_order = results_te(min_test_err_idx, 1); %fetching the order of polynomial

fold_start = min_test_err_idx - rem(min_test_err_idx - 1, max_p + 1); % recovering the fold start 
fold_end = fold_start + max_p; % recovering the fold end

p1 = plot_errors(results_tr(fold_start:fold_end, :), 'b'); % plotting the R training
hold on;
p2 = plot_errors(results_te(fold_start:fold_end, :), 'r'); % plotting the R testing
legend([p1 p2],{'avg R of train set','avg R of test set'}, 'Location','NorthWest');

variables = vars{min_test_err_idx}; % fetching the variable arrangement
poly = get_polynomial(min_test_err_order, variables); %polynomial reconstruction
sprintf("Features selected: [%s]",join(variables))

sprintf("Polynomial order: %d\nMin test error  : %f", min_test_err_order, min_test_err/(N/K)) % MSE

Z = expand(poly, X); %recontruct the Z
y_pred = ws{min_test_err_idx}' * Z; %calculating y prediction
training_error = sum((y - y_pred').^2)/N; % MSE
sprintf("Polynomial order: %d\nTraining error  : %f", min_test_err_order, training_error)

Z = expand(poly, Test); %reconstruc Z test
y_pred = ws{min_test_err_idx}' * Z; %y prediction
dlmwrite('predicted_values.txt', num2str(y_pred','%.7e\t'),'delimiter', ''); 

function [A] = get_combination(vars)
    n = numel(vars);%number of variables
    max = (2^n)-1; % iterations (possible combination)
    pad_size = length(dec2bin(max));
    A = repmat("",max,n); %initializing A
    for i=1:max
        comb = pad(dec2bin(i),pad_size,'left','0');
        for j=1:n
            if(comb(j) == '1')
                A(i,j) = vars(1,j);
            else
                A(i,j) = "na";
            end
        end
    end
end
