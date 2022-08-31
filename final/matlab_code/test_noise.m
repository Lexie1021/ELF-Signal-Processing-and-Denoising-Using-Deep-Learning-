% load received_noise.mat;
% load impulse_noise1.mat;
% load sin_noise.mat;

% received_noise2(1:1600,:) = received_noise(1:1600,:);
% received_noise2(1601:2400,:) = received_noise(1601:2400,:).*0.4;
% received_noise2(2401:3000,:) = received_noise(2401:3000,:).*0.35;
% received_noise2(3001:3983,:) = received_noise(3001:3983,:).*0.25;

% sin_noise_2 = add_noise(received_sin,received_noise2);
% impulse_noise1_2 = add_noise(received_impulse,received_noise2);
% impulse_noise2_2 = add_noise(received_impulse2,received_noise2);
% save sin_noise_2.mat;
% save impulse_noise1_2.mat;
% save impulse_noise2_2.mat;
% save received_noise2.mat;
% 
% load simulated_sin.mat;
% load simulated_impulse.mat;
% load simulated_impulse_noise.mat;
% load simulated_sin_noise.mat;
% load simulated_noises.mat;
%%
% load impulse_received.mat;
% load impulse2_received.mat;
% load sin_received.mat;
% load noise_received.mat;
% load noise_impulse1.mat;
% load noise_impulse2.mat;
% load noise_sin.mat;
load E:\data\noise_impulse.mat;
load E:\data\noise_received.mat;
load E:\data\impulse2_received.mat;
%% Plot
num = 3400;
a1 = noise_impulse2(num,:);
subplot(3,1,1);
plot(a1);
title('A segment of impulse signal with noise(1 second)');
xlabel('Sample');
ylabel('Amplitude');
grid on;
xlim([0,512]);


subplot(3,1,2);
Y=fft(a1);
fs = 512;
L = 512;
P2 = abs(Y/L);
P1 = P2(1:L/2+1);
P1(2:end-1) = 2*P1(2:end-1);
f = fs*(0:(L/2))/L;
plot(f,P1);
title('Single-sided amplitude spectrum of signal')
xlabel('Frequency(Hz)')
ylabel('Amplitude');
grid on;
xlim([0,150]);
% ylim([0,200]);

subplot(3,1,3);
[pxx1,w1] = periodogram(a1);
[pxx2,w2] = periodogram(noise_received(num,:));
[pxx3,w3] = periodogram(impulse2_received(num,:));
plot(w1,10*log10(pxx1));
hold on;
plot(w2,10*log10(pxx2));
hold on;
plot(w3,10*log10(pxx3));
grid on;
legend('impulse+noise','noise','impulse')
xlabel('Normalized Frequency(rad/sample)');
ylabel('Power/Frequency(dB/(rad/sample))')
title('Power spectral density estimate ')
ylim([-80,10]);
