function [Q, R] = Householder(A)
  row = rows (A);
  col = columns (A);
  Q = eye (row);
  for j = 1:col
    V = zeros (row,1);
    V(j, 1) = sign(A(j,j)) * sqrt(A(j:row, j)' * A(j:row, j)) + A(j,j);
    V(j+1:row, 1) = A(j+1:row, j);
    H = eye (row) - (2 .* ((V * V') ./ (V' * V)));
    A = H * A;
    Q = Q * H';
  endfor
  R = A;
endfunction