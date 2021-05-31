% grating_sqr diffraction grating example
lambda=0.5e-6;                                                              %wavelength 
f=0.5;                                                                      %propagation distance
P=1e-4;                                                                     %grating period
D1=1e-3;                                                                    %grating side length
L1=1e-2;                                                                    %array side length
M=1000;                                                                     %# samples
dx1=L1/M; 
x1=-L1/2:dx1:L1/2-dx1;                                                      %source coords 
y1=x1;
[X1,Y1]=meshgrid(x1,x1);                                                    %construct grating field 
fc=fft(fftshift(ucomb(x1/P))); 
fr=fft(fftshift(rect(x1/(P/2)))); 
ux=ifftshift(ifft(fc.*fr));                                                 %1D conv rect & comb 
u1=repmat(ux,M,1);                                                          %replicate to 2D
u1=u1.*rect(X1/D1).*rect(Y1/D1);                                            %set size 
I1=abs(u1.^2);                                                              %src irradiance
figure(1) 
imagesc(x1,y1,I1); 
axis square; 
axis xy; 
colormap('gray'); 
xlabel('x (m)'); 
ylabel('y (m)'); 
title('z= 0 m');
% Fraunhofer pattern 
[u2,L2]=propFF(u1,L1,lambda,f); 
dx2=L2/M; 
x2=-L2/2:dx2:L2/2-dx2; 
y2=x2;                                                                      %obs coords 
I2=abs(u2).^2;
figure(2)                                                                   %display obs irrad
imagesc(x2,y2,nthroot(I2,3)); 
axis square; 
axis xy; 
colormap('gray'); 
xlabel('x (m)'); 
ylabel('y (m)'); 
title(['z= ',num2str(f),' m']); 
figure(3)                                                                   %irradiance profile
plot(x2,I2(M/2+1,:));
xlabel('x (m)'); 
ylabel('Irradiance'); 
title(['z= ',num2str(f),' m']);
%analytic
lf=lambda*f;
u2a=zeros(1,M);
for n=-5:5
    ut=sinc(n/2)*sinc(D1/lf*(x2-n*lf/P)); u2a=u2a+ut;
end
u2a=D1^2/(2*lf)*u2a;
I2a=abs(u2a).^2;
I2a=repmat(I2a,M,1);
figure(4)                                                                   %irradiance profile
plot(x2,I2(M/2+1,:));
hold on;
plot(x2,I2a(M/2+1,:));
xlabel('x (m)'); 
ylabel('Irradiance'); 
title(['z= ',num2str(f),' m']);