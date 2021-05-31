function[u2]=propIR(u1,L,lambda,z);                                         % propagation - impulse response approach 
% assumes same x and y side lengths and uniform sampling 5 
% u1 - source plane field 
% L - source and observation plane side length 
% lambda - wavelength 
% z - propagation distance 
% u2 - observation plane field 
[M,N]=size(u1);                                                             %get input field array size
dx=L/M;                                                                     %sample interval
k=2*pi/lambda;                                                              %wavenumber
x=-L/2:dx:L/2-dx;                                                           %spatial coords
[X,Y]=meshgrid(x,x); 
h=1/(j*lambda*z)*exp(j*k/(2*z)*(X.^2+Y.^2));                                %impulse 
H=fft2(fftshift(h))*dx^2;                                                   %create trans func 
U1=fft2(fftshift(u1));                                                      %shift, fft src field
U2=H.*U1;                                                                   %multiply
u2=ifftshift(ifft2(U2));                                                    %inv fft, center obs field 
end
