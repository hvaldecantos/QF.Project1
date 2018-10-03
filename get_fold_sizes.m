function [FoldSizes] = get_fold_sizes(X, number_of_folds) %926 and 10
    N = length(X); %926
    fold_size = floor(N / number_of_folds); %92=926/10
    FoldSizes = repmat(fold_size,1,number_of_folds); %[92 92 ... 92] ten times
    FoldSizes(1, 1:rem(N, number_of_folds)) = FoldSizes(1, 1:rem(N, number_of_folds)) + 1; 
    %not lossing 6 observation 
end