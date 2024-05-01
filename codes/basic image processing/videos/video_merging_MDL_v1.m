video_reader = VideoReader('toy.mp4');
video_writer = VideoWriter('toy_processed.mp4','MPEG-4');                  %create the video object
video_writer.FrameRate = video_reader.FrameRate;
open(video_writer);                                                        %open the file for writing
for i=1:135                                                                %where N is the number of images
  filename = strcat('frame-',num2str(i),'.png');
  I = imread(filename);
  writeVideo(video_writer,I);                                              %write the image to file
end
close(video_writer);                                                       %close the file


