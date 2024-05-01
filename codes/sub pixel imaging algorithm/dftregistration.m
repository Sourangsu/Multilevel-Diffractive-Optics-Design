function [output, Greg] = dftregistration(buf1ft,buf2ft,usfac)
if ~exist('usfac','var')
    usfac = 1;
end

[nr,nc]=size(buf2ft);
Nr = ifftshift(-fix(nr/2):ceil(nr/2)-1);
Nc = ifftshift(-fix(nc/2):ceil(nc/2)-1);

if usfac == 0
    % Simple computation of error and phase difference without registration
    CCmax = sum(buf1ft(:).*conj(buf2ft(:)));
    row_shift = 0;
    col_shift = 0;
elseif usfac == 1
    % Single pixel registration
    CC = ifft2(buf1ft.*conj(buf2ft));
    CCabs = abs(CC);
    [row_shift, col_shift] = find(CCabs == max(CCabs(:)));
    CCmax = CC(row_shift,col_shift)*nr*nc;
    % Now change shifts so that they represent relative shifts and not indices
    row_shift = Nr(row_shift);
    col_shift = Nc(col_shift);
elseif usfac > 1
    % Start with usfac == 2
    CC = ifft2(FTpad(buf1ft.*conj(buf2ft),[2*nr,2*nc]));
    CCabs = abs(CC);
    [row_shift, col_shift] = find(CCabs == max(CCabs(:)),1,'first');
    CCmax = CC(row_shift,col_shift)*nr*nc;
    % Now change shifts so that they represent relative shifts and not indices
    Nr2 = ifftshift(-fix(nr):ceil(nr)-1);
    Nc2 = ifftshift(-fix(nc):ceil(nc)-1);
    row_shift = Nr2(row_shift)/2;
    col_shift = Nc2(col_shift)/2;
    % If upsampling > 2, then refine estimate with matrix multiply DFT
    if usfac > 2,
        %%% DFT computation %%%
        % Initial shift estimate in upsampled grid
        row_shift = round(row_shift*usfac)/usfac; 
        col_shift = round(col_shift*usfac)/usfac;     
        dftshift = fix(ceil(usfac*1.5)/2); %% Center of output array at dftshift+1
        % Matrix multiply DFT around the current shift estimate
        CC = conj(dftups(buf2ft.*conj(buf1ft),ceil(usfac*1.5),ceil(usfac*1.5),usfac,...
            dftshift-row_shift*usfac,dftshift-col_shift*usfac));
        % Locate maximum and map back to original pixel grid 
        CCabs = abs(CC);
        [rloc, cloc] = find(CCabs == max(CCabs(:)),1,'first');
        CCmax = CC(rloc,cloc);
        rloc = rloc - dftshift - 1;
        cloc = cloc - dftshift - 1;
        row_shift = row_shift + rloc/usfac;
        col_shift = col_shift + cloc/usfac;    
    end

    % If its only one row or column the shift along that dimension has no
    % effect. Set to zero.
    if nr == 1,
        row_shift = 0;
    end
    if nc == 1,
        col_shift = 0;
    end
    
end  

rg00 = sum(abs(buf1ft(:)).^2);
rf00 = sum(abs(buf2ft(:)).^2);
error = 1.0 - abs(CCmax).^2/(rg00*rf00);
error = sqrt(abs(error));
diffphase = angle(CCmax);

output=[error,diffphase,row_shift,col_shift];

% Compute registered version of buf2ft
if (nargout > 1)&&(usfac > 0),
    [Nc,Nr] = meshgrid(Nc,Nr);
    Greg = buf2ft.*exp(1i*2*pi*(-row_shift*Nr/nr-col_shift*Nc/nc));
    Greg = Greg*exp(1i*diffphase);
elseif (nargout > 1)&&(usfac == 0)
    Greg = buf2ft*exp(1i*diffphase);
end
return

function out=dftups(in,nor,noc,usfac,roff,coff)
[nr,nc]=size(in);
% Set defaults
if exist('roff', 'var')~=1, roff=0;  end
if exist('coff', 'var')~=1, coff=0;  end
if exist('usfac','var')~=1, usfac=1; end
if exist('noc',  'var')~=1, noc=nc;  end
if exist('nor',  'var')~=1, nor=nr;  end
% Compute kernels and obtain DFT by matrix products
kernc=exp((-1i*2*pi/(nc*usfac))*( ifftshift(0:nc-1).' - floor(nc/2) )*( (0:noc-1) - coff ));
kernr=exp((-1i*2*pi/(nr*usfac))*( (0:nor-1).' - roff )*( ifftshift([0:nr-1]) - floor(nr/2)  ));
out=kernr*in*kernc;
return


function [ imFTout ] = FTpad(imFT,outsize)
if ~ismatrix(imFT)
    error('Maximum number of array dimensions is 2')
end
Nout = outsize;
Nin = size(imFT);
imFT = fftshift(imFT);
center = floor(size(imFT)/2)+1;

imFTout = zeros(outsize);
centerout = floor(size(imFTout)/2)+1;

% imout(centerout(1)+[1:Nin(1)]-center(1),centerout(2)+[1:Nin(2)]-center(2)) ...
%     = imFT;
cenout_cen = centerout - center;
imFTout(max(cenout_cen(1)+1,1):min(cenout_cen(1)+Nin(1),Nout(1)),max(cenout_cen(2)+1,1):min(cenout_cen(2)+Nin(2),Nout(2))) ...
    = imFT(max(-cenout_cen(1)+1,1):min(-cenout_cen(1)+Nout(1),Nin(1)),max(-cenout_cen(2)+1,1):min(-cenout_cen(2)+Nout(2),Nin(2)));

imFTout = ifftshift(imFTout)*Nout(1)*Nout(2)/(Nin(1)*Nin(2));
return


