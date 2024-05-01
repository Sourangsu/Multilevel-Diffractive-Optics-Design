% sqr_beam propagation 
L1=0.5;                                                                     %side length 
M=250;                                                                      %number of samples
dx1=L1/M;                                                                   %src sample interval
x1=-L1/2:dx1:L1/2-dx1;                                                      %src coords 
y1=x1;      
lambda=0.5*10^-6;                                                           %wavelength
k=2*pi/lambda;                                                              %wavenumber
w=0.011;                                                                    %source half width (m)
z=2000;                                                                     %propagation dist (m)
[X1,Y1]=meshgrid(x1,y1); 
u1=rect(X1/(2*w)).*rect(Y1/(2*w));                                          %src field 
I1=abs(u1.^2);                                                              %src irradiance
figure(1) 
imagesc(x1,y1,I1); 
axis square; 
axis xy; 
colormap('gray'); 
xlabel('x (m)'); 
ylabel('y (m)'); 
title('z= 0 m');
[u2,L2]=propFF(u1,L1,lambda,z); 
I2=abs(u2.^2);                                                              %obs irrad
dx2=L2/M;
x2=-L2/2:dx2:L2/2-dx2;                                                      %obs ords 
y2=x2;
imagesc(x2,y2,nthroot(I2,3));                                               %stretch image contrast
axis square; 
axis xy; 
colormap('gray'); 
xlabel('x (m)'); 
ylabel('y (m)'); 
title(['z= ',num2str(z),' m']);                        
