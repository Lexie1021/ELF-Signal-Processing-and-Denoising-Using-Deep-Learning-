function output = separate_sig(sig1,sig2,sig3,sig4)
l1 = length(sig1); l2 = length(sig2);
l3 = length(sig3); l4 = length(sig4);
sig_length = l1+l2+l3+l4;
sig = zeros(sig_length,1);
sig(1:l1) = sig1;
sig(l1+1:l1+l2) = sig2;
sig(l1+l2+1:l1+l2+l3) = sig3;
sig(l1+l2+l3+1:l1+l2+l3+l4)=sig4;
len = int32(sig_length);
f = int32(512);
num = idivide(len,f,'floor');% the raw signal cannot be in multiples of 512
sig = sig(1:512*num); 
output = zeros(num,512);

for h = 0:num-1
  output(h+1,:) = sig(h*512+1:h*512+512)./395;
  h = h+1;
    
end

