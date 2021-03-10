function [w] = learn(X, y)
  [nl nc] = size (X);
  X(:, nc+1) = 1;
  [Q R] = Householder(X);
  b = Q' * y;
  [w] = SST(R, b);
end
