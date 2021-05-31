function[uout]=focus(uin,L,lambda,zf) % converging or diverging phase-front 
% uniform sampling assumed 
% uin - input field 
% L - side length 
% lambda - wavelength 
% zf - focal distance (+ converge, - diverge) 
% uout - output field 
[M,N]=size(uin);                                                            %get input field array size
dx=L/M;                                                                     %sample interval
k=2*pi/lambda;                                                              %wavenumber
x=-L/2:dx:L/2-dx;                                                           %coords
[X,Y]=meshgrid(x,x); 
uout=uin.*exp(-1i*k/(2*zf)*(X.^2+Y.^2));                                     %apply focus 
end