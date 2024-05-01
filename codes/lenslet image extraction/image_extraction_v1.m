clear all;clc;
A = imread('dice_png_2.png');
A_red = A(:,:,1);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%red channel
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
l = 1;
for i = 1:40
    for j = 1:1550
        for  k = l:l+49
        B_red(j,k) = A_red(j,k);
        end
    end
    if(i < 10)
        currentFile = sprintf('B_red_0%d.mat',i);
        save(currentFile,'B_red');
    else
       currentFile = sprintf('B_red_%d.mat',i);
       save(currentFile,'B_red');
    end
       clear B_red;
       l = l+50;     
end;

clear all;clc;
files = dir('B_red_*.mat');
out = load(files(1).name);
for k = 2:numel(files)
    out(k) = load(files(k).name);
end

l = 51;
n = 2;
for m = 2:length(out)
    B_red = out(m).B_red;
    B_red = B_red(:,l:end);
    if(n < 10)
        currentFile = sprintf('B_red_0%d.mat',n);
        save(currentFile,'B_red');
    else
        currentFile = sprintf('B_red_%d.mat',n);
        save(currentFile,'B_red');
    end
    l = l+50;
    n = n+1;
end


clear all;clc;
files = dir('B_red_*.mat');
out = load(files(1).name);
for k = 2:numel(files)
    out(k) = load(files(k).name);
end


n = 1;
for m = 1:length(out)
    B_red = out(m).B_red;
    l = 1;
    for i = 1:31
        for j = l:l+49
            for  k = 1:50
                C_red(j,k) = B_red(j,k);
            end
        end
        if(n < 10 && i < 10)
            currentFile = sprintf('C_red_0%d_0%d.mat',n,i);
            save(currentFile,'C_red');
        elseif(n < 10 && i >= 10)
            currentFile = sprintf('C_red_0%d_%d.mat',n,i);
            save(currentFile,'C_red');
        elseif(n >= 10 && i < 10)
            currentFile = sprintf('C_red_%d_0%d.mat',n,i);
            save(currentFile,'C_red');
        else
            currentFile = sprintf('C_red_%d_%d.mat',n,i);
            save(currentFile,'C_red');
        end
        clear C_red;
        l = l+50;
    end;
    n = n+1;
end

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
    out = load(files(1).name);
    for k = 2:numel(files)
        out(k) = load(files(k).name);
    end
    
    l = 1;
    n = 1;
    for m = 1:length(out)
        
        C_red = out(m).C_red;
        C_red = C_red(l:end,:);
        if(i < 10 && n < 10)
            currentFile = sprintf('C_red_0%d_0%d.mat',i,n);
            save(currentFile,'C_red');
        elseif(i < 10 && n >= 10)
            currentFile = sprintf('C_red_0%d_%d.mat',i,n);
            save(currentFile,'C_red');
        elseif(i >= 10 && n < 10)
            currentFile = sprintf('C_red_%d_0%d.mat',i,n);
            save(currentFile,'C_red');
        else
            currentFile = sprintf('C_red_%d_%d.mat',i,n);
            save(currentFile,'C_red');
        end
        l = l+50;
        n = n+1;
    end

end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


clear all;clc;
A = imread('dice_png_2.png');
A_blue = A(:,:,2);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%blue channel
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
l = 1;
for i = 1:40
    for j = 1:1550
        for  k = l:l+49
        B_blue(j,k) = A_blue(j,k);
        end
    end
    if(i < 10)
        currentFile = sprintf('B_blue_0%d.mat',i);
        save(currentFile,'B_blue');
    else
       currentFile = sprintf('B_blue_%d.mat',i);
       save(currentFile,'B_blue');
    end
       clear B_blue;
       l = l+50;     
end;

clear all;clc;
files = dir('B_blue_*.mat');
out = load(files(1).name);
for k = 2:numel(files)
    out(k) = load(files(k).name);
end

l = 51;
n = 2;
for m = 2:length(out)
    B_blue = out(m).B_blue;
    B_blue = B_blue(:,l:end);
    if(n < 10)
        currentFile = sprintf('B_blue_0%d.mat',n);
        save(currentFile,'B_blue');
    else
        currentFile = sprintf('B_blue_%d.mat',n);
        save(currentFile,'B_blue');
    end
    l = l+50;
    n = n+1;
end


clear all;clc;
files = dir('B_blue_*.mat');
out = load(files(1).name);
for k = 2:numel(files)
    out(k) = load(files(k).name);
end


n = 1;
for m = 1:length(out)
    B_blue = out(m).B_blue;
    l = 1;
    for i = 1:31
        for j = l:l+49
            for  k = 1:50
                C_blue(j,k) = B_blue(j,k);
            end
        end
        if(n < 10 && i < 10)
            currentFile = sprintf('C_blue_0%d_0%d.mat',n,i);
            save(currentFile,'C_blue');
        elseif(n < 10 && i >= 10)
            currentFile = sprintf('C_blue_0%d_%d.mat',n,i);
            save(currentFile,'C_blue');
        elseif(n >= 10 && i < 10)
            currentFile = sprintf('C_blue_%d_0%d.mat',n,i);
            save(currentFile,'C_blue');
        else
            currentFile = sprintf('C_blue_%d_%d.mat',n,i);
            save(currentFile,'C_blue');
        end
        clear C_blue;
        l = l+50;
    end;
    n = n+1;
end

clear all;clc;
for i = 1:40
    str_num = num2str(i);
    if(i < 10)
        dir_name = strcat('C_blue_0',str_num);
    else
        dir_name = strcat('C_blue_',str_num);
    end
    dir_name_full = strcat(dir_name,'_*.mat');
    files = dir(dir_name_full);
    out = load(files(1).name);
    for k = 2:numel(files)
        out(k) = load(files(k).name);
    end
    
    l = 1;
    n = 1;
    for m = 1:length(out)
        
        C_blue = out(m).C_blue;
        C_blue = C_blue(l:end,:);
        if(i < 10 && n < 10)
            currentFile = sprintf('C_blue_0%d_0%d.mat',i,n);
            save(currentFile,'C_blue');
        elseif(i < 10 && n >= 10)
            currentFile = sprintf('C_blue_0%d_%d.mat',i,n);
            save(currentFile,'C_blue');
        elseif(i >= 10 && n < 10)
            currentFile = sprintf('C_blue_%d_0%d.mat',i,n);
            save(currentFile,'C_blue');
        else
            currentFile = sprintf('C_blue_%d_%d.mat',i,n);
            save(currentFile,'C_blue');
        end
        l = l+50;
        n = n+1;
    end

end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


clear all;clc;
A = imread('dice_png_2.png');
A_green = A(:,:,3);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%green channel
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
l = 1;
for i = 1:40
    for j = 1:1550
        for  k = l:l+49
        B_green(j,k) = A_green(j,k);
        end
    end
    if(i < 10)
        currentFile = sprintf('B_green_0%d.mat',i);
        save(currentFile,'B_green');
    else
       currentFile = sprintf('B_green_%d.mat',i);
       save(currentFile,'B_green');
    end
       clear B_green;
       l = l+50;     
end;

clear all;clc;
files = dir('B_green_*.mat');
out = load(files(1).name);
for k = 2:numel(files)
    out(k) = load(files(k).name);
end

l = 51;
n = 2;
for m = 2:length(out)
    B_green = out(m).B_green;
    B_green = B_green(:,l:end);
    if(n < 10)
        currentFile = sprintf('B_green_0%d.mat',n);
        save(currentFile,'B_green');
    else
        currentFile = sprintf('B_green_%d.mat',n);
        save(currentFile,'B_green');
    end
    l = l+50;
    n = n+1;
end


clear all;clc;
files = dir('B_green_*.mat');
out = load(files(1).name);
for k = 2:numel(files)
    out(k) = load(files(k).name);
end


n = 1;
for m = 1:length(out)
    B_green = out(m).B_green;
    l = 1;
    for i = 1:31
        for j = l:l+49
            for  k = 1:50
                C_green(j,k) = B_green(j,k);
            end
        end
        if(n < 10 && i < 10)
            currentFile = sprintf('C_green_0%d_0%d.mat',n,i);
            save(currentFile,'C_green');
        elseif(n < 10 && i >= 10)
            currentFile = sprintf('C_green_0%d_%d.mat',n,i);
            save(currentFile,'C_green');
        elseif(n >= 10 && i < 10)
            currentFile = sprintf('C_green_%d_0%d.mat',n,i);
            save(currentFile,'C_green');
        else
            currentFile = sprintf('C_green_%d_%d.mat',n,i);
            save(currentFile,'C_green');
        end
        clear C_green;
        l = l+50;
    end;
    n = n+1;
end

clear all;clc;
for i = 1:40
    str_num = num2str(i);
    if(i < 10)
        dir_name = strcat('C_green_0',str_num);
    else
        dir_name = strcat('C_green_',str_num);
    end
    dir_name_full = strcat(dir_name,'_*.mat');
    files = dir(dir_name_full);
    out = load(files(1).name);
    for k = 2:numel(files)
        out(k) = load(files(k).name);
    end
    
    l = 1;
    n = 1;
    for m = 1:length(out)
        
        C_green = out(m).C_green;
        C_green = C_green(l:end,:);
        if(i < 10 && n < 10)
            currentFile = sprintf('C_green_0%d_0%d.mat',i,n);
            save(currentFile,'C_green');
        elseif(i < 10 && n >= 10)
            currentFile = sprintf('C_green_0%d_%d.mat',i,n);
            save(currentFile,'C_green');
        elseif(i >= 10 && n < 10)
            currentFile = sprintf('C_green_%d_0%d.mat',i,n);
            save(currentFile,'C_green');
        else
            currentFile = sprintf('C_green_%d_%d.mat',i,n);
            save(currentFile,'C_green');
        end
        l = l+50;
        n = n+1;
    end

end
