function Z = expand(fs, X) % converts the X into Z
    [Mfs Nfs] = size(fs);
    [Mx Nx] = size(X);
    Z = zeros(Nfs, Mx);
    for i=1:length(fs)
        f = fs{i}{1}; % function
        k = fs{i}{2}; % index to know what data to apply
        Z(i,:) = f(X(:,k));
    end
end
