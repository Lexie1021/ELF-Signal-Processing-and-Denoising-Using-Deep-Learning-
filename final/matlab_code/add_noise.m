function output = add_noise(sig,noise)
    [row_sig,col_sig] = size(sig);
    [row_noise,col_noise] = size(noise);
    if row_sig<=row_noise
       noise1 = noise(1:row_sig,:);
       output = sig+noise1;
    end
end