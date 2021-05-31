%fft2_example - 2D FFT example 
wx=0.1;                                                                     %rect x half-width (m)
wy=0.05;                                                                    %rect y half-width (m)
L=2;                                                                        %side length x&y (m)
M=200;                                                                      %samples/side length
dx=L/M;                                                                     %sample interval (m)
x=-L/2:dx:L/2-dx;                                                           %x coordinates 
y=x;                                                                        %y coordinates
[X,Y]=meshgrid(x,y);                                                        %X and Y grid coords 
g=rect(X/(2*wx)).*rect(Y/(2*wy));                                           %signal


figure(1)
imagesc(x,y,g);                                                             %image display
colormap('gray');                                                           %linear gray display map 
axis square;                                                                %square figure
axis xy                                                                     %y positive up 
xlabel('x (m)'); 
ylabel('y (m)');

figure(2) 
plot(x,g(M/2+1,:));                                                         %x slice profile
xlabel('x (m)'); 
axis([-1,1,0,1.2]);

g0=fftshift(g);                                                             %shift
G0=fft2(g0)*dx^2;                                                           %2D fft and dxdy scaling 
G=fftshift(G0);                                                             %center
fx=-1/(2*dx):1/L:1/(2*dx)-(1/L);                                            %x freq coords 
fy=fx;                                                                      %y freq coords

figure(3) 
surf(fx,fy,abs(G)) %display transform magnitude 
camlight left; lighting phong
colormap('gray'); 
shading interp; 
ylabel('fy (cyc/m)'); 
xlabel('fx (cyc/m)'); 

figure(4) 
plot(fx,abs(G(M/2+1,:)));                                                   %fx slice profile 
title('magnitude'); 
xlabel('fx (cyc/m)');


