clear all;clc;
for i = 1:40
    str_num = num2str(i);
    if(i < 10)
        dir_name = strcat('C_red_0',str_num);
    else
        dir_name = strcat('C_red_',str_num);
    end
    dir_name_full = strcat(dir_name,'_*.mat');
    files = dir(dir_name_full);
    out_1 = load(files(1).name);
    for k = 2:numel(files)
        out_1(k) = load(files(k).name);
    end
    
    if(i < 10)
        dir_name = strcat('C_blue_0',str_num);
    else
        dir_name = strcat('C_blue_',str_num);
    end
    dir_name_full = strcat(dir_name,'_*.mat');
    files = dir(dir_name_full);
    out_2 = load(files(1).name);
    for k = 2:numel(files)
        out_2(k) = load(files(k).name);
    end
    
    if(i < 10)
        dir_name = strcat('C_green_0',str_num);
    else
        dir_name = strcat('C_green_',str_num);
    end
    dir_name_full = strcat(dir_name,'_*.mat');
    files = dir(dir_name_full);
    out_3 = load(files(1).name);
    for k = 2:numel(files)
        out_3(k) = load(files(k).name);
    end
    
    n = 1;
    for m = 1:length(out_1)
        C_red = out_1(m).C_red;
        C_blue = out_2(m).C_blue;
        C_green = out_3(m).C_green;
        C = cat(3,C_red,C_blue,C_green);
        if(i < 10 && n < 10)
            currentFile = sprintf('img_0%d_0%d.mat',i,n);
            save(currentFile,'C');
        elseif(i < 10 && n >= 10)
            currentFile = sprintf('img_0%d_%d.mat',i,n);
            save(currentFile,'C');
        elseif(i >= 10 && n < 10)
            currentFile = sprintf('img_%d_0%d.mat',i,n);
            save(currentFile,'C');
        else
            currentFile = sprintf('img_%d_%d.mat',i,n);
            save(currentFile,'C');
        end
       n = n+1;
    end
    
end


%imwrite(pic7,'pic7.tif','tif');
