function [sol] = hsvHistogram(path_to_image, count_bins)
  img = imread (path_to_image);
  img = (double)(img)/255;
  
  # extrag valorile pentru r, g si b din img
  red = img(:, :, 1);
  green = img(:, :, 2);
  blue = img(:, :, 3);

  [nl nc] = size (green);

  H = zeros (nl,nc);
  S = zeros (nl,nc);
  V = zeros (nl,nc);
  A = zeros (1,nc);
  
  # construiesc H, S, V
    c_max = max (img,[],3);
    c_min = min (img,[],3);
    delta = c_max - c_min;
    A = (delta == 0);
      H(A) = 0;
    A = (c_max == red & delta != 0);
        H(A) = 60 * mod(((green(A) - blue(A))./delta(A)), 6);
    A =(c_max == green & delta != 0);
        H(A) = 60 * (((blue(A) - red(A))./delta(A)) + 2);
    A = (c_max == blue & delta!= 0);
        H(A) = 60 * (((red(A) - green(A))./delta(A)) + 4);
       H = H / 360;
    A = (c_max == 0);
      S(A) = 0;
    A = (c_max != 0);
      S(A) = delta(A)./c_max(A);
    V = c_max;   
    
    
  H = idivide ((double)(H(:)), 1.01/count_bins);
  S = idivide ((double)(S(:)), 1.01/count_bins);
  V = idivide( (double)(V(:)), 1.01/count_bins);

  H = H(:) + 1;
  S = S(:) + 1;
  V = V(:) + 1;

# este construita histograma pentru h, s si v
  H = accumarray (H(:), 1, [count_bins 1]);
  S = accumarray (S(:), 1, [count_bins 1]);
  V = accumarray (V(:), 1, [count_bins 1]);

sol = [H' S' V'];
endfunction