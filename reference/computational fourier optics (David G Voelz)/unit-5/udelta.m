function[out]=udelta(x)                                                     %unit sample “delta” function
% unit value for x=0
% round is used to truncate roundoff error %
x=round(x*10^6)/10^6;                                                       %round to 10^6ths place 
out=x==0;                                                                   %place 1 in out where x = 0
end