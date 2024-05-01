clear;
clc;

for i = 1:135
    filename = strcat('frame-',num2str(i),'.png');
    I = imread(filename);
    I1= wbalance(I);
    %I1 = I;
    
    %red channel
    I2 = I1(:,:,1);
    I3 = im2double(I2);
    I4 = imsharpen(I3,'Radius',6,'Amount',8);
    I5 = medfilt2(I4,[8 8]);
    I_red = I5;
    
    
    %green channel
    I2 = I1(:,:,2);
    I3 = im2double(I2);
    I4 = imsharpen(I3,'Radius',6,'Amount',8);
    I5 = medfilt2(I4,[8 8]);
    I_green = I5;
    
    
    %blue channel
    I2 = I1(:,:,3);
    I3 = im2double(I2);
    I4 = imsharpen(I3,'Radius',6,'Amount',8);
    I5 = medfilt2(I4,[8 8]);
    I_blue = I5;
    
    I_final = cat(3,I_red,I_green,I_blue);
    filename = strcat('C:\Users\ECE\Desktop\processed_frames\frame-',num2str(i),'.png');
    imwrite(I_final,filename);
end




