function x = back_substitute(A, b)
  [Ma Na] = size(A);
  [Mb Nb] = size(b);
  if(Na ~= Mb) %multiplication of matrices criteria
      error("cannot multiply matrices") 
  end
  x = zeros(Mb, Nb); 
  for i = Na:-1:1
    c = b(i);
    for j=i+1:Na
      c = c - A(i,j)*x(j);
    end
    x(i) = c/A(i,i);
  end
end