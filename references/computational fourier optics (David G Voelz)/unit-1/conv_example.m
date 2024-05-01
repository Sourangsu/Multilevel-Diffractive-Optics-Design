% conv_example - Convolution: two Gaussian functions 
wa=0.3;                                                                     %Gaussian 1 width [exp(-pi) radius](m) 
wb=0.2;                                                                     %Gaussian 2 width [exp(-pi) radius](m) 
L=2;                                                                        %side length (meters)
M=200;                                                                      %number of samples
dx=L/M;                                                                     %sample interval (m) 
x=[-L/2:dx:L/2-dx];                                                         %x coordinates
fa=exp(-pi*(x.^2)/wa^2);                                                    %Gaussian a 
fb=exp(-pi*(x.^2)/wb^2);                                                    %Gaussian b 
figure(1) 
plot(x,fa,x,fb,'--'); 
title ('functions'); 
xlabel('x (m)');

Fa=fft(fa);%transform fa
Fb=fft(fb);%transform fb
F0=Fa.*Fb;%multiply pointwise
f0=ifft(F0)*dx;%inverse transform and scale
f=fftshift(f0);%center result
figure(2)
plot(x,f); 
title('convolution')
xlabel('x (m)')