function W=wbalance(im)

im2=im;
im1=rgb2ycbcr(im);
Lu=im1(:,:,1);
Cb=im1(:,:,2);
Cr=im1(:,:,3);
[x y z]=size(im);
tst=zeros(x,y);
Mb=sum(sum(Cb));
Mr=sum(sum(Cr));
Mb=Mb/(x*y);
Mr=Mr/(x*y);
Db=sum(sum(Cb-Mb))/(x*y);
Dr=sum(sum(Cr-Mr))/(x*y);
cnt=1;
Ciny = zeros(1,x*y);

mask=logical(((Cb-(Mb+Db*sign(Mb)))<(1.5*Db)) .* ((Cr-(1.5*Mr+Dr*sign(Mr)))<(1.5*Dr)));
Ciny=reshape(Lu(mask),sum(sum(mask)),1);

cnt=numel(mask)+1;

Ciny(cnt:end) = [];
cnt=cnt-1;
iy=sort(Ciny,'descend');
nn=round(cnt/10);
Ciny2(1:nn)=iy(1:nn);

tst(Lu(mask)>=min(Ciny2))=1;

R=im(:,:,1);
G=im(:,:,2);
B=im(:,:,3);
R=double(R).*tst;
G=double(G).*tst;
B=double(B).*tst;
Rav=mean(mean(R));
Gav=mean(mean(G));
Bav=mean(mean(B));
Ymax=double(max(max(Lu)))/15;
Rgain=Ymax/Rav;
Ggain=Ymax/Gav;
Bgain=Ymax/Bav;
im(:,:,1)=im(:,:,1)*Rgain;
im(:,:,2)=im(:,:,2)*Ggain;
im(:,:,3)=im(:,:,3)*Bgain;
W=im.*0.75;
%figure,imshow(im2,[]),title('Original Image');
%figure,imshow(im,[]),title('Corrected Image');
end