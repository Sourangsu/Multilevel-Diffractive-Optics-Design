for i = 1:40
    str_num = num2str(i);
    if(i < 10)
        dir_name = strcat('img_0',str_num);
    else
        dir_name = strcat('img_',str_num);
    end
    dir_name_full = strcat(dir_name,'_*.mat');
    files = dir(dir_name_full);
    out = load(files(1).name);
    for k = 2:numel(files)
        out(k) = load(files(k).name);
    end
    
        
    n = 1;
    for m = 1:length(out)
        C = out(m).C;
        str_1 = num2str(i);
        str_2 = num2str(n);
        if(i < 10 && n < 10)
            str_concat_1 = strcat('C:\Users\ECE\Desktop\dataset\img_0',str_1);
            str_concat_2 = strcat(str_concat_1,'_0');
            str_concat_3 = strcat(str_concat_2,str_2);
            str_concat_4 = strcat(str_concat_3,'.tif');
            imwrite(C,str_concat_4,'tif');
        elseif(i < 10 && n >= 10)
            str_concat_1 = strcat('C:\Users\ECE\Desktop\dataset\img_0',str_1);
            str_concat_2 = strcat(str_concat_1,'_');
            str_concat_3 = strcat(str_concat_2,str_2);
            str_concat_4 = strcat(str_concat_3,'.tif');
            imwrite(C,str_concat_4,'tif');
        elseif(i >= 10 && n < 10)
            str_concat_1 = strcat('C:\Users\ECE\Desktop\dataset\img_',str_1);
            str_concat_2 = strcat(str_concat_1,'_0');
            str_concat_3 = strcat(str_concat_2,str_2);
            str_concat_4 = strcat(str_concat_3,'.tif');
            imwrite(C,str_concat_4,'tif');
        else
            str_concat_1 = strcat('C:\Users\ECE\Desktop\dataset\img_',str_1);
            str_concat_2 = strcat(str_concat_1,'_');
            str_concat_3 = strcat(str_concat_2,str_2);
            str_concat_4 = strcat(str_concat_3,'.tif');
            imwrite(C,str_concat_4,'tif');
        end
        n = n+1;
    end
end
