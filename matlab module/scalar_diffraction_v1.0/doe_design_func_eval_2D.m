function [x,X,Y,normIxy] = doe_design_func_eval_2D(Lambda,Z,L,del_L,H,n,P,resolution,bound_cond,mat,ctrl_flag_propagator_krnl,substrate_ref_indx,substrate_abs_coeff)
lambda = Lambda;                                                           %wavelength
z = Z;                                                                     %propagation distance
l = L;                                                                     %aperture side length
del_l = del_L;                                                             %pixel width
m = round(l/del_l);                                                        %number of samples
h = H;                                                                     %maximum height (m)    
N = n;                                                                     %number of levels
del_h = h/(N-1);                                                           %unit height (m)
res_padd = 5;

x = linspace(-l/2,l/2,m);
y = x;
dx = x(2)-x(1);
dy = dx;
x_shift = dx:dx:l+2*dx;                                                    %shifted coordinate vector
y_shift = x_shift;
[X,Y]=meshgrid(x,x);


%% Pixel Height Distribution
m = round(m);
p = P;
n = single(interp1(mat(:,1), mat(:,2), lambda, 'linear', 'extrap'));
K = single(interp1(mat(:,1), mat(:,3), lambda, 'linear', 'extrap')); 
k = (2*pi)/lambda;                                                         %wave vector
alp = k*del_h*((n+(1i*K))-1);                                              %material property
km = exp(1i*alp*p);                                                        %height distribution vector


%% Construct Source Field Aperture
for i = 1:m
    for j = 1:m
        A(j,i) = sum(rect_v2((x_shift-i*dx)/dx).*rect_v2((y_shift-i*dy)/dy)*km(j,i));
    end
end
                                                     
u = A;


if (bound_cond == 1)
    %% Scale Source Field Aperture
    L1 = l;                                                                %array side length
    M1 = resolution*m;                                                     %# samples
    dx1 = L1/M1;
    x1 = -L1/2:dx1:L1/2-dx1;                                               %source coords
    y1 = x1;
    [X1,Y1]=meshgrid(x1,x1);
    
    
    u1=interp2(X,Y,u,X1,Y1,'cubic',0);
    I1 = abs(u1.^2);
end


%% Construct Source Field
L2 = res_padd*L1;                                                          %array side length
M2 = res_padd*M1;                                                          %# samples
dx2 = L2/M2;
x2 = -L2/2:dx2:L2/2-dx2;                                                   %source coords
y2 = x2;
[X2,Y2] = meshgrid(x2,x2);


%% Create Source Field Aperture 
u2 = padarray(u1,[(res_padd-1)/2*M1 (res_padd-1)/2*M1]);
I2 = abs(u2.^2); 


if (ctrl_flag_propagator_krnl == 1)
    n2 = substrate_ref_indx;
    k2 = substrate_abs_coeff;
    lambda = lambda/(n2+i*k2);                                             %polymer
else
    lambda = lambda/1;                                                     %air
end


%% Fresnel Propagator
u3=propTF_2D(u2,L2,lambda,z);                                              %propagation


%% Construct Observation Field
x3 = x2;                                                                   %obs field coordinates
y3 = y2;
I3 = abs(u3.^2);                                                           %obs field intensity
[X3,Y3] = meshgrid(x2,x2);


%% Normalize (if required)
Ixy = I3;
%normIxy = Ixy./max(Ixy(:));
normIxy = Ixy;


x = x3;
X = X3;
Y = Y3;

end

