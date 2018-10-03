function p = get_polynomial(degree, vars) % order and variables
    index = 1;
    p{index} = {str2func(sprintf("@(x) ones(length(x),1)")), 1}; % bias
    
    for v = 1:length(vars)
        if(vars(v) ~= "na") % discard the varribale
            for i=1:degree
                index = index + 1;
                p{index} = {str2func(sprintf("@(%s)(%s.^%d)",vars(v),vars(v),i)), v}; % cell of function
                % p{index} = {str2func(sprintf("@(%s)(sin(%s.^(1/%d)))",vars(v),vars(v),i)), v};
                % p{index} = {str2func(sprintf("@(%s)(sin(%s.^(1/%d)))",vars(v),vars(v),i)), v};
            end
        end
    end
end
