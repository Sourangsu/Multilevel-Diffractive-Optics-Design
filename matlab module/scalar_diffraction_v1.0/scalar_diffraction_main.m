%% code for scalar diffraction
%% workspace definition
close all;
clear all;
clc;

%%%%%%% Parameter Definition (User Input) %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%% general parameter definition
lambda = [0.550]*1e-6;                                                     %wavelength
z = 1e-3;                                                                  %propagation distance
z_prop = linspace(0.2e-3,5e-3,250);                                        %propagation distance array
l = 0.150e-3;                                                              %aperture side length
del_l = 3e-6;                                                              %pixel width
m = round(l/del_l);                                                        %number of samples (Note: even number of pixels)
h = 2.6e-6;                                                                %maximum height (m)
N = 100;                                                                   %number of levels
del_h = h/(N-1);                                                           %each pixel height
n_hlf_pxls = m/2;                                                          %pixels in symmetry (Note: even number of pixels)
min_hght = 0;                                                              %mimimum height in doe
max_hght = N-1;                                                            %maximum height in doe
substrate_ref_indx = 1;                                                    %(default 1)refractive index of substrate
substrate_abs_coeff = 0;                                                   %absorption coefficienct of substrate


%% resolution parameters
resolution_2D = 5;                                                         %resolution required for post-processing [default is 3]


%% boundary parameters
bound_cond = 1;                                                            %boundary condition to be used [1 = PML, 2 = Periodic]


%% primary control parameters
ctrl_flag_post_process_valid = 1;                                          %default 0 (set to 1 to only post process)


%% secondary control parameters
ctrl_flag_propagator_krnl = 0;                                             %default 0 (set to 1 to propagate in polymer)
ctrl_flag_post_valid_1D_psf = 0;                                           %default 0 (set to 1 to view 1D psf)
ctrl_flag_post_valid_2D_psf = 1;                                           %default 0 (set to 1 to view 2D psf)
ctrl_flag_post_valid_z_prop = 1;                                           %default 0 (set to 1 to view z propagation)
ctrl_flag_post_valid_1D_pxl = 0;                                           %default 0 (set to 1 to view 1D pixel profile)
ctrl_flag_post_valid_2D_pxl = 0;                                           %default 0 (set to 1 to view 2D pixel profile)


%% functionsf
fcn_name_conv_doe1Dto2D = 'convdoe_func_1Dto2D';                           %name of convert 1Dto2D does file
fcn_name_eval_doe2D = 'doe_design_func_eval_2D';                           %evaluate 2D doe scalar file


%% file paths
file_path_pxl_prfl = 'C:\Users\ECE\Desktop\scalar_diffraction_v1.0\oPxl.mat';     %give full file path name
file_path_mat_data = 'C:\Users\ECE\Desktop\scalar_diffraction_v1.0\mat_S1813.xlsx';%give full file path name


%%%%%%% Warning!! Do not change code here onwards! %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fprintf('Process Started........\n');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fprintf('Pre-Process Validation Routine Started........\n');			   %process message
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if isempty(file_path_mat_data)
    fprintf('Error: No file name specified for material.\n');
    return;
else
    mat = xlsread(file_path_mat_data);                                     %load start profile vector or matrix
end

if isempty(fcn_name_conv_doe1Dto2D)									       %check for error
    fprintf('Error: No function call file name specified.\n');
    return;
end

if isempty(fcn_name_eval_doe2D)										       %check for error
    fprintf('Error: No function call file name specified.\n');
    return;
end

if isempty(file_path_pxl_prfl)
    fprintf('Error: No file path specified.\n');
    return;
else
    load(file_path_pxl_prfl);                                               %load start profile vector or matrix
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fprintf('Check for Post-Process Validation Routine Started........\n');    %process message
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if (ctrl_flag_post_process_valid == 1)
    %% convert 1D doe to 2D doe
    fprintf('Saving Post Process Results........\n');
    clear(fcn_name_conv_doe1Dto2D);                                        %flush out any previous iteration
    [x,X,Y,oPxl_2D] = feval(fcn_name_conv_doe1Dto2D,l,del_l,oPxl);
    
    if (ctrl_flag_post_valid_1D_pxl == 1)
        fig = figure(100);
        stem(fliplr(oPxl));
    end
    
    if (ctrl_flag_post_valid_2D_pxl == 1)
        fig = figure(101);
        imagesc(oPxl_2D);
        shading interp;
        colorbar;
    end
    
    if (ctrl_flag_post_valid_z_prop == 1 && ctrl_flag_post_valid_2D_psf == 0 && ctrl_flag_post_valid_1D_psf == 0)
        for k=1:length(lambda)
            for k_z =1:length(z_prop)
                clear(fcn_name_eval_doe2D);                                %flush out any previous iteration
                [x_norm,X_norm,Y_norm,normIxy] = feval(fcn_name_eval_doe2D, ...
                    lambda(k),z_prop(k_z),l,del_l,h,N,oPxl_2D,resolution_2D,bound_cond,mat,ctrl_flag_propagator_krnl,...
                    substrate_ref_indx,substrate_abs_coeff);
                In= normIxy((length(normIxy)/2)+1,:);
                I_total(k_z,:) = In';
            end
            fig = figure(k);
            pcolor(z_prop,x_norm,I_total');
            shading interp;
            colormap('jet');
            xlabel('z (m)');
            ylabel('x (m)');
        end
    end
    
    
    %%simulate 2D doe
    for k=1:length(lambda)
        clear(fcn_name_eval_doe2D);                                        %flush out any previous iteration
        [x_norm,X_norm,Y_norm,normIxy] = feval(fcn_name_eval_doe2D, ...
            lambda(k),z,l,del_l,h,N,oPxl_2D,resolution_2D,bound_cond,mat,ctrl_flag_propagator_krnl,...
            substrate_ref_indx,substrate_abs_coeff);
        if (ctrl_flag_post_valid_1D_psf == 1 && ctrl_flag_post_valid_2D_psf == 1)
            fprintf('!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!\n');
            fprintf('Error Message:: Conflicting status flags! Reason: Both ctrl_flag_post_valid_1D_psf == 1 and ctrl_flag_post_valid_2D_psf == 1 cannot be 1 at the same time! ...........\n');
            fprintf('!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!\n');
        end;
        if (ctrl_flag_post_valid_1D_psf == 1 && ctrl_flag_post_valid_2D_psf == 0)
            fig = figure(k);
            In= normIxy((length(normIxy)/2)+1,:);
            Xn = x_norm;
            plot(Xn,In);
            xlim([-l/2 l/2]);
            xlabel('x (m)');
            ylabel('normalized intensity (a.u.)');
        end
        if (ctrl_flag_post_valid_1D_psf == 0 && ctrl_flag_post_valid_2D_psf == 1)
            fig = figure(k);
            pcolor(X_norm,Y_norm,normIxy);
            xlim([-l/2 l/2]);
            ylim([-l/2 l/2]);
            xlabel('x (m)');
            ylabel('y (m)');
            shading interp;
            colorbar;
            colormap('jet');
        end
    end
else
    fprintf('No Post Process Validation Routine Selected...........\n');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fprintf('Check for Post-Process Validation Routine Completed........\n');  %process message
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


