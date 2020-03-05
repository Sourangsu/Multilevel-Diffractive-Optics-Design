function T = transmission_diff_lens_h(dd, r, h)
if length(h) ~= length(r)
    disp('Error: length of heights not equal to length of radii.\n');
end

T = zeros(size(dd));

for cnt=1:length(r)
    if cnt==1
        index = find(dd<=r(cnt));
        T(index) = h(cnt);
    else
        index = find(dd<=r(cnt) & dd>r(cnt-1));
        T(index) = h(cnt);
    end
end

