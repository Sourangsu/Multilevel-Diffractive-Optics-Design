% fresnel lens hyperbolic lens - paraxial approxmiation - planar wavefront

clear all
clc

lambda=1e-3;                                                                  %wavelength
f=0.075;                                                                      %propagation distance
z=f;
w=50e-3;

L1=30e-2;                                                                     %array side length
M= 900;                                                                       %# samples
dx1=L1/M;
x1=-L1/2:dx1:L1/2-dx1;                                                        %source coords
y1 = x1;
[X1,Y1]=meshgrid(x1,x1);

r = sqrt(X1.^2 + Y1.^2);
k = ((2*pi)/lambda);

s = 2*f;
a = 2*w;
alpha = (a-s)/s;

u = -(k/alpha).*sqrt((alpha^2.*X1.^2) + (alpha.*sqrt(Y1.^2 + f^2)+f).^2);

% field and irradiance
u1=1/2*(1-sign(cos(u))).*rect_v2(X1/a).*rect_v2(Y1/a);
I1=abs(u1.^2);                                                                 %src irradiance

figure(1)
imagesc(x1,y1,I1);
axis square; axis xy;
colormap('gray'); xlabel('x (m)'); 
ylabel('y (m)');
title('z= 0 m');

figure(2)
mesh(x1,y1,u1); 
axis square; axis xy;
colormap('default'); xlabel('x (m)'); 
ylabel('y (m)');
title('z= 0 m');

u2=propTF(u1,L1,lambda,z);                                                     %propagation

x2=x1;                                                                         %obs coords
y2=y1;
I2=abs(u2.^2);                                                                 %obs irrad

figure(3)                                                                      %display obs irrad
imagesc(x2,y2,I2);
axis square; axis xy;
colormap('gray'); xlabel('x (m)'); 
ylabel('y (m)');
title(['z= ',num2str(z),' m']);
%
figure(4)                                                                      %irradiance profile
plot(x2*1e3,I2(M/2+1,:));
xlabel('x (m)'); ylabel('Irradiance');
title(['z= ',num2str(z),' m']);
axis([-100 100 0 10]);
%
figure(5)                                                                      %plot obs field mag
plot(x2,abs(u2(M/2+1,:)));
xlabel('x (m)'); ylabel('Magnitude');
title(['z= ',num2str(z),' m']);
%
figure(6)                                                                      %plot obs field phase
plot(x2,unwrap(angle(u2(M/2+1,:))));
xlabel('x (m)'); ylabel('Phase (rad)');
title(['z= ',num2str(z),' m']);

