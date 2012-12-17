function [green,prob] = verd(imatge)

RGB_r = imatge(:,:,1);
RGB_g = imatge(:,:,2);       
RGB_b = imatge(:,:,3);

green = sum(sum(RGB_g(:,:)));
red = sum(sum(RGB_r(:,:)));
blue = sum(sum(RGB_b(:,:)));

sumatori = green + red + blue;
prob = green/sumatori;