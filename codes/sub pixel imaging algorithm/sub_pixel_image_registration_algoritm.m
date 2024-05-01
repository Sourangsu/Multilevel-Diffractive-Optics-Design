%sub-pixel imaging algorithm 3
ImageName1 = importdata ('1DNarrow_Raw_50mm_C.dat',',');
ImageName1=ImageName1.data;
ImageName2 = importdata ('1DNarrow_Raw_50mm_L1.dat',',');
ImageName2=ImageName2.data;
usfac = 100;
[output, Greg] = dftregistration(fft2(ImageName1),fft2(ImageName2),usfac);
display(output);

figure(1);
subplot(1,2,1);
imshow(abs(ImageName1));
title('Reference image, f(x,y)')
subplot(1,2,2);
imshow(abs(ifft2(ImageName2)));
title('Registered image, gr(x,y)')