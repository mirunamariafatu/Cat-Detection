function [X, y] = preprocess(path_to_dataset, histogram, count_bins)
  X = zeros (1, count_bins*3);
  type = char(histogram);
  
  # extrag histogramele pozelor cu pisici
  path_cats = strcat(path_to_dataset, 'cats/');
  [ imgs ]  = getImgNames (path_cats);
  [m n] = size (imgs);
  y = zeros (m,1);
  
  if strcmp(type, 'RGB') == 1
    for i = 1:m
      img = imgs(i,:);
      path = strcat(path_cats, img);
      X(i,:) = rgbHistogram (path, count_bins);
      y(i,1) = 1;
    endfor
  else
    for i = 1:m
      img = imgs(i,:);
      path = strcat(path_cats, img);
      X(i,:) = hsvHistogram (path, count_bins);
      y(i,1) = 1;
    endfor
  endif
  
  # extrag histogramele pozelor fara pisici
  path_not_cats = strcat(path_to_dataset, 'not_cats/');
  [ imgs_not ] = getImgNames (path_not_cats);
  [nl nc] = size (imgs_not);
  l = 1;
  
  if strcmp(type, 'RGB') == 1
    for j = m+1 : m+nl
      img = imgs_not(l,:);
      path = strcat(path_not_cats, img);
      X(j,:) = rgbHistogram (path, count_bins);
      y(j,1) = -1;
      l++;
    endfor
  else
    for j = m + 1:m + nl
      img = imgs_not(l,:);
      path = strcat(path_not_cats, img);
      X(j,:) = hsvHistogram (path, count_bins);
      y(j,1) = -1;
      l++;
    endfor
  endif
    
endfunction

