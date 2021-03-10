function [x] = SST(A, b)
  n = columns (A);
  x = zeros (n,1);
  for i = n:-1:1
    x(i) = (b(i) - sum (A(i, (i+1):n) * x((i+1):n, 1)))./A(i,i);
  endfor
end
    