clear;
clc;

I = imread('figure6.png');
I1= wbalance(I);
%I1 = I;

%red channel
I2 = I1(:,:,1);
I3 = im2double(I2);
I4 = imsharpen(I3,'Radius',6,'Amount',8);
figure(1);
subplot(3,3,1);
imshow(I3);
title('red-original');
subplot(3,3,2);
imshow(I4);
title('red-sharpen');
I5 = medfilt2(I4,[8 8]);
subplot(3,3,3);
imshow(I5);
title('red-final');
I_red = I5;


%green channel
I2 = I1(:,:,2);
I3 = im2double(I2);
I4 = imsharpen(I3,'Radius',6,'Amount',8);
figure(1);
subplot(3,3,4);
imshow(I3);
title('green-original');
subplot(3,3,5);
imshow(I4);
title('green-sharpen');
I5 = medfilt2(I4,[8 8]);
subplot(3,3,6);
imshow(I5);
title('green-final');
I_green = I5;


%blue channel
I2 = I1(:,:,3);
I3 = im2double(I2);
I4 = imsharpen(I3,'Radius',6,'Amount',8);
figure(1);
subplot(3,3,7);
imshow(I3);
title('blue-original');
subplot(3,3,8);
imshow(I4);
title('blue-sharpen');
I5 = medfilt2(I4,[8 8]);
subplot(3,3,9);
imshow(I5);
title('blue-final');
I_blue = I5;



I_final = cat(3,I_red,I_green,I_blue);
figure(2);
subplot(1,2,1);
imshow(I);
subplot(1,2,2);
imshow(I_final);