load simulated_impulse.mat;
load simulated_sin.mat;
load simulated_noises.mat;
% load E:\data\impulse2_received.mat;
% load E:\data\sin_received.mat;
% load E:\data\noise_impulse.mat;
% load E:\data\noise_sin.mat;
% load E:\data\noise_received.mat;


% sin power
sin_l = length(simulated_sin);
sin_p = zeros(sin_l,1);
for i = 1:sin_l
    sin_p(i,:) = sqrt(mean(abs(simulated_sin(i,:)).^2));
    i = i+1;
end

noise_l = length(simulated_noises);
noise_p = zeros(sin_l,1);
for a = 1:noise_l
    noise_p(a,:) = sqrt(mean(abs(simulated_noises(a,:)).^2));
    a = a+1;
end
noise_p = noise_p(1:sin_l,:);

SNR_sin = zeros(sin_l,1);
for b = 1:sin_l
    SNR_sin(b) = 10*log10(sin_p(b)/noise_p(b));
    b = b+1;
end

%% impulse snr
impulse_l = length(simulated_impulse);
impulse_p = zeros(impulse_l,1);
for i = 1:impulse_l
    impulse_p(i,:) = mean(abs(simulated_impulse(i,:)).^2);
    i = i+1;
end

% noise_l = length(noise_received);
% noise_p = zeros(impulse_l,1);
% for a = 1:noise_l
%     noise_p(a,:) = sqrt(mean(abs(noise_received(a,:)).^2));
%     a = a+1;
% end
% noise_p = noise_p(1:impulse_l,:);

SNR_impulse = zeros(impulse_l,1);
for b = 1:impulse_l
    SNR_impulse(b) = 10*log10(impulse_p(b)/noise_p(b));
    b = b+1;
end