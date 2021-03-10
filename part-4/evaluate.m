function [percentage] = evaluate(path_to_testset, w, histogram, count_bins)
  corect = 0;
  [X] = preprocess(path_to_testset, histogram, count_bins);
  
  # scalez matricea si adaug 1 pe ultima coloana
  X(:, 1:columns(X)) = (X(:, 1:columns(X)) - mean(X(:, 1:columns(X)))) ./ std(X(:, 1:columns(X)));
  X(:, columns(X)+1) = 1;
  y = w' * X';
  
  path_cats = strcat(path_to_testset, 'cats/');
  [ imgs ]  = getImgNames (path_cats);
  [r_cats n_cats] = size (imgs);
  
  path_not_cats = strcat(path_to_testset, 'not_cats/');
  [ imgs ]  = getImgNames (path_not_cats);
  [r_not n_not] = size (imgs);
  
  # verific eticheta imaginilor
  for i = 1:r_cats
    if y(i) >= 0
      corect++;
    endif
  endfor
  
  for j = r_cats + 1:columns(y)
    if y(j) < 0
      corect++;
    endif
  endfor

  # calculez procentajul final
  total = r_cats + r_not;
  percentage = corect / total;
endfunction