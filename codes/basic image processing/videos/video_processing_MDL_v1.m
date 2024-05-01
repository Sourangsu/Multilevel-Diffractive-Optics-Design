obj = VideoReader('toy.mp4');
for i = 1:obj.NumberOfFrames
    filename = strcat('C:\Users\ECE\Desktop\extracted_frames\frame-',num2str(i),'.png');
    img = read(obj,i);
    imwrite(img,filename);
end
