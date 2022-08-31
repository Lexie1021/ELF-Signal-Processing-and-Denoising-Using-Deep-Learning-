% Yiqing wang 
% 02066717
clc
clear
close all;
%% load data 

%% sin data 
load E:\master\final_project\matlab_code\sin_raw_data\sin_20_min1.csv;
load E:\master\final_project\matlab_code\sin_raw_data\sin_20_min2.csv;
load E:\master\final_project\matlab_code\sin_raw_data\sin_20_min3.csv;

sin_sig2_16min = sin_20_min2(:,2);
save sin_sig2_16min.mat
sin_sig1_21min = sin_20_min3(:,2);
save sin_sig1_21min.mat
sin_sig3_23min = sin_20_min1(:,2);
save sin_sig3_23min.mat

received_sin1 = separate_sig(sin_sig2_16min,sin_sig1_21min,sin_sig3_23min,[]);
save received_sin.mat;
a = impulse_2nd_20min3(1:512);
plot(a);
title ('Received raw impulse signal of 1 second');
xlabel('Sample');
ylabel('Ampilitude')
xlim([0,512]);
grid on;

%% load impulse data 
% load impulse_20_min1.csv;
% load impulse_20_min2.csv;
% load impulse_20_min3.csv;
% 
% impulse_sig1_20min = impulse_20_min1(:,2);
% save impulse_sig1_20min.mat;
% impulse_sig2_18min = impulse_20_min2(:,2);
% save impulse_sig2_18min.mat;
% impulse_sig3_23min = impulse_20_min3(:,2);
% save impulse_sig3_23min.mat;
% 
% received_impulse = separate_sig(impulse_sig1_20min,impulse_sig2_18min,impulse_sig3_23min,[]);
% save received_impulse.mat;

%% load another impulse data 
% load impulse_2nd_sig1.csv;
% load impulse_2nd_sig2.csv;
% load impulse_2nd_sig3.csv;
% 
% impulse_2nd_20min1 = impulse_2nd_sig1(:,2);
% save impulse_2nd_20min1.mat;
% impulse_2nd_20min2 = impulse_2nd_sig2(:,2);
% save impulse_2nd_20min2.mat;
% impulse_2nd_20min3 = impulse_2nd_sig3(:,2);
% save impulse_2nd_20min3.mat;
% 
% received_impulse2 = separate_sig(impulse_2nd_20min1,impulse_2nd_20min2,impulse_2nd_20min3,[]);
% save received_impulse2.mat

%% load noise
% load noise_sig1_15min.csv;
% load noise_sig2_15min.csv;
% load noise_sig3_14min.csv;
% load noise_sig4_22min.csv;
% noise1_15min = noise_sig1_15min(:,2);
% save noise1_15min.mat;
% noise2_15min = noise_sig2_15min(:,2);
% save noise2_15min.mat;
% noise3_14min = noise_sig3_14min(:,2);
% save noise3_14min.mat;
% noise4_22min = noise_sig4_22min(:,2);
% save noise4_22min.mat;
% 
% received_noise = separate_sig(noise1_15min,noise2_15min,noise3_14min,noise4_22min);
% save received_noise.mat;
% 
% %% plot 1s segment of the received signal
% s = 51200;
% a1 = received_noise(2874,:);
% % a = mean(a1);
% % a1 = a1-a;
% 
subplot(3,1,1);
a1 = rev
plot(a1);
title('A segment of received impulse signal (1 second)');
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
title('Single-Sided Amplitude Spectrum of X(t)')
xlabel('f (Hz)')
ylabel('Amplitude');
grid on;
xlim([0,150]);
% ylim([0,200]);

subplot(3,1,3);
[pxx,w] = periodogram(a1);
plot(w,10*log10(pxx));
grid on;
xlabel('Normalized Frequency(rad/sample)');
ylabel('Power/Frequency(dB/(rad/sample))')
title('Power Spectral Density Estimate ')
% ylim([-100,100]);

%% add noise to signal
load received_noise.mat;
load received_impulse.mat;
load received_impulse2.mat;
load received_sin.mat;

sin_noise = add_noise(received_sin,received_noise);
save sin_noise.mat;
impulse_noise1 = add_noise(received_impulse,received_noise);
save impulse_noise1.mat;
impulse_noise2 = add_noise(received_impulse2,received_noise);
save impulse_noise2.mat;

%% plot 1s segment of the received signal
s = 51200;
a1 = impulse_noise1(2,:);
% a = mean(a1);
% a1 = a1-a;

subplot(3,1,1);
plot(a1);
title('A segment of received impulse signal (1 second)');
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
title('Single-Sided Amplitude Spectrum of X(t)')
xlabel('f (Hz)')
ylabel('Amplitude');
grid on;
xlim([0,150]);
% ylim([0,200]);

subplot(3,1,3);
[pxx,w] = periodogram(a1);
plot(w,10*log10(pxx));
grid on;
xlabel('Normalized Frequency(rad/sample)');
ylabel('Power/Frequency(dB/(rad/sample))')
title('Power Spectral Density Estimate ')
% % ylim([-100,100]);



