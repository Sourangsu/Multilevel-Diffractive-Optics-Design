function[out]=ucomb(x)                                                      %unit sample “comb” function 
% sequence of unit values for x=integer value 
% round is used to truncate roundoff error %
x=round(x*10^6)/10^6;                                                       %round to 10^6ths place 
out=rem(x,1)==0;                                                            %place 1 in out where rem = 0
end