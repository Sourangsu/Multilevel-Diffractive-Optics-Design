function[u2]=propTF(u1,L,lambda,z)
[M,N]=size(u1);                                 		%get input field array size
dx=L/M;                                         		%sample interval
k=2*pi/lambda;                                  		%wavenumber

fx=-1/(2*dx):1/L:1/(2*dx)-1/L;                  		%freq coords
[FX,FY]=meshgrid(fx,fx);

x=-L/2:dx:L/2-dx;                               		%spatial coords
[X,Y]=meshgrid(x,x); 

%H=exp(-j*pi*lambda*z*(FX.^2+FY.^2));            		%trans func
%H=exp(1i*2*pi*z*sqrt(1-lambda^2*(FX.^2+FY.^2))/lambda);
h=1/(1i*1-lambda^2*z)*exp(1i*k/(2*z)*(X.^2+Y.^2));		%impulse 
H=fft2(fftshift(h))*dx^2; 								%create trans func
%H=fftshift(H);                                  		%shift trans func
U1=fft2(fftshift(u1));                          		%shift, fft src field
U2=H.*U1;                                       		%multiply
u2=ifftshift(ifft2(U2));                        		%inv fft, center obs field
end