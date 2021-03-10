function [sol] = rgbHistogram(path_to_image, count_bins)
  img = imread (path_to_image);

  # extrag valorile pentru r, g si b din img
  red = img(:, :, 1);
  green = img(:, :, 2);
  blue = img(:, :, 3);

  red = idivide (red(:), 256/count_bins);
  green = idivide (green(:), 256/count_bins);
  blue = idivide (blue(:), 256/count_bins);

  red = red(:) + 1;
  blue = blue(:) + 1;
  green = green(:) + 1;

  # este construita histograma pentru r, g si b
  red = accumarray (red(:), 1, [count_bins 1]);
  green = accumarray (green(:), 1, [count_bins 1]);
  blue = accumarray (blue(:), 1, [count_bins 1]);

  sol = [red' green' blue'];
endfunction