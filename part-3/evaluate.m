function [percentage] = evaluate(path_to_testset, w, histogram, count_bins)
  X = zeros (1, count_bins*3);
  type = char(histogram);
  
  # extrag histogramele pozelor cu pisici
  path_cats = strcat(path_to_testset, 'cats/');
  [ imgs ]  = getImgNames (path_cats);
  [m n] = size (imgs);
  y = zeros (m,1);
  corect = 0;
  
  if strcmp(type, 'RGB') == 1
    for i = 1:m
      img = imgs(i,:);
      path = strcat(path_cats, img);
      X = rgbHistogram (path, count_bins);
      X(1, columns(X)+1) = 1;
      y = w' * X';
      if y >= 0
        corect++;
      endif
    endfor
  else
    for i = 1:m
      img = imgs(i,:);
      path = strcat(path_cats, img);
      X = hsvHistogram (path, count_bins);
      X(1, columns(X)+1) = 1;
      y = w' * X';
      if y >= 0
        corect++;
      endif
    endfor
  endif
  
  # extrag histogramele pozelor fara pisici
  path_not_cats = strcat(path_to_testset, 'not_cats/');
  [ imgs_not ] = getImgNames (path_not_cats);
  [nl nc] = size (imgs_not);
  l = 1;
  
  if strcmp(type, 'RGB') == 1
    for j = m + 1:m + nl
      img = imgs_not(l,:);
      path = strcat(path_not_cats, img);
      X = rgbHistogram (path, count_bins);
      l++;
      X(1, columns(X)+1) = 1;
      y = w' * X';
      if y < 0
        corect++;
      endif
    endfor
  else
    for j = m + 1:m + nl
      img = imgs_not(l,:);
      path = strcat(path_not_cats, img);
      X = hsvHistogram (path, count_bins);
      l++;
      X(1, columns(X)+1) = 1;
      y = w' * X';
      if y < 0
        corect++;
      endif
    endfor
  endif
  
  # calculez procentajul final
  nr_imgs = m + nl;
  percentage = corect / nr_imgs;
endfunction