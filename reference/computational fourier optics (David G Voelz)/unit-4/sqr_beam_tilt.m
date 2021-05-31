% sqr_beam propagation
L1=0.5;                                                                     %side length 
M=250;                                                                      %number of samples
dx1=L1/M;                                                                   %src sample interval
x1=-L1/2:dx1:L1/2-dx1;                                                      %src coords 
y1=x1;      
lambda=0.5*10^-6;                                                           %wavelength
k=2*pi/lambda;                                                              %wavenumber
w=0.051;                                                                    %source half width (m)
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
deg=pi/180;
alpha=5.0e-5;                                                               %rad 
theta=45*deg;
[u1]=tilt(u1,L1,lambda,alpha,theta);
u2=propTF(u1,L1,lambda,z);                                                  %propagation 
%u2=propIR(u1,L1,lambda,z);                                                  %propagation
x2=x1;                                                                      %obs coords
y2=y1; 
I2=abs(u2.^2);                                                              %obs irrad
figure(2)                                                                   %display obs irrad
imagesc(x2,y2,I2); 
axis square; 
axis xy; 
colormap('gray'); 
xlabel('x (m)'); 
ylabel('y (m)'); 
title(['z= ',num2str(z),' m']); 
figure(3)                                                                   %irradiance profile
plot(x2,I2(M/2+1,:));
xlabel('x (m)'); 
ylabel('Irradiance'); 
title(['z= ',num2str(z),' m']); 
figure(4)                                                                   %plot obs field mag
plot(x2,abs(u2(M/2+1,:))); 
xlabel('x (m)'); 
ylabel('Magnitude'); 
title(['z= ',num2str(z),' m']); 
figure(5)                                                                   %plot obs field phase 
plot(x2,unwrap(angle(u2(M/2+1,:))));
xlabel('x (m)'); 
ylabel('Phase (rad)'); 
title(['z= ',num2str(z),' m']);

                   
