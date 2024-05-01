function[u2,L2]=propFF(u1,L1,lambda,z)                                       % propagation - Fraunhofer pattern 
% assumes uniform sampling 
% u1 - source plane field 
% L1 - source plane side length 
% lambda - wavelength 
% z - propagation distance 
% L2 - observation plane side length 
% u2 - observation plane field 
[M,N]=size(u1);                                                             %get input field array size
dx1=L1/M;                                                                   %source sample interval
k=2*pi/lambda;                                                              %wavenumber
L2=lambda*z/dx1;                                                            %obs sidelength
dx2=lambda*z/L1;                                                            %obs sample interval
x2=-L2/2:dx2:L2/2-dx2;                                                      %obs coords
[X2,Y2]=meshgrid(x2,x2); 
c=1/(1i*lambda*z)*exp(1i*k/(2*z)*(X2.^2+Y2.^2)); 
u2=c.*ifftshift(fft2(fftshift(u1)))*dx1^2; 
end
