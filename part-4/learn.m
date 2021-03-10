function [w] = learn(X, y, lr, epochs)
  [nl nc] = size (X);
  
  # scalez matricea si adaug 1 pe ultima coloana
  X(:, 1:columns(X)) = (X(:, 1:columns(X)) - mean(X(:, 1:columns(X)))) ./ std(X(:, 1:columns(X)));
  X(:,nc+1) = 1;
  
  # generez vectorul w random
  col = columns(X);
  a = -0.1;
  b = 0.1;
  w = a + (b - a) .* rand (col,1);
  
  for j = 1:epochs
    k = randi (nl , 64, 1); # obtin batch_size nr random din intervalul [1 nr.poze]
    X_batch = X(k,:);
    y_batch = y(k,1);
    for m = 1:col
      w(m) = w(m) - lr * 1 / nl * sum(((X_batch(1:64, :) * w - y_batch(1:64))) .* X_batch(1:64, m));
    endfor
  endfor
endfunction

