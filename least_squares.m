function [M R w] = least_squares(Z, y) % input parameters Z and y
  [p N] = size(Z);
  M = zeros(size(Z,1)); % initializing Z
  s = zeros(size(Z,1),1); % initalizing s
  M = Z*Z'; % calculating M
  s = Z*y; % calculating s
  [Ap bp] = triangularize(M,s);% function call to triangularize which converts into upper triangular
  w = back_substitute(Ap,bp); % calculating w by backsubstitution
  y_pred = w' * Z; 
  R = norm(y - y_pred')^2; % calculating R 
end
