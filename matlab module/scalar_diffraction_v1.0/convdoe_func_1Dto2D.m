function [x,X,Y,dsgn1_pxl_2D_fl] = convdoe_func_1Dto2D(L,del_L,P)
l = L;                                                                     %aperture side length
del_l = del_L;                                                             %pixel width
m = round(l/del_l);                                                        %number of samples

%define coordinates
x = linspace(-l/2,l/2,m);
dx = x(2)-x(1);

%generate 1D pixel heights
Pxl = [P,fliplr(P)];

%define 2D coordinates
[X,Y]=meshgrid(x,x);
dd = sqrt(X.^2+Y.^2);
r = x;

%generate 2D pixel heights
dsgn1_pxl_2D_fl = transmission_diff_lens_h(dd,r,Pxl);

end

