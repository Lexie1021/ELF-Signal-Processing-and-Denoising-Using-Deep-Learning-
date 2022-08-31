
clc
clear
close all;
%% Parameter
Fs = 512; 
T=1/Fs;                  
L=512;
NFFT=L;
t=(0:L-1)*T;
%% Digital LFP
fn=1024;
fp=50;  
fs=100;  
Rp=3;  
Rs=30;
Wp=fp/(fn/2); % normalized frequency
Ws=fs/(fn/2);
[n,Wn]=buttord(Wp,Ws,Rp,Rs);% Calculated order and cut frequency
[b,a]=butter(n,Wn);         % Calculated H(z), the parameter of numerator and denominator
[H,F]=freqz(b,a,NFFT/2+1,1002);      % Calculated impulse response of H(z)
%% Generate noise
   
simulated_noises = zeros(3000,512);
for i = 1:3000
    aa = wgn(512,1,0,'real');
%     Y=fft(aa,NFFT)/L;              
%     % filter out the high frequnecy component
%     A=2*abs(Y(1:NFFT/2+1)).*(abs(H));
%     
%     % ifft
%     p = NFFT/2+1;
%     A = A';
%     for c=1:L-p
%         A(1,(p+c))=A(1,(p-c));
%     end
% 
%     z=A'.*exp(1i*angle(Y));
%     z2=real(ifft(z));
%     simulated_noises(i,:) = z2*NFFT/2;
    simulated_noises(i,:) = aa;
    i = i+1;
end

%%
save simulated_noises.mat;
load simulated_impulse.mat;
load simulated_sin.mat;
simulated_noises2 = simulated_noises.*0.35;
simulated_sin_noise = add_noise(simulated_sin,simulated_noises);
save simulated_sin_noise.mat;
simulated_impulse_noise = add_noise(simulated_impulse,simulated_noises2);
save simulated_impulse_noise.mat;

% plot(simulated_sin_noise(45,:))
%% Plot
num =200;
a1 = simulated_noises(num,:);
subplot(3,1,1);
plot(a1);
title('A segment of simulated noise(1 second)');
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
xlabel('f (Hz)')
ylabel('Amplitude');
grid on;
xlim([0,150]);
% ylim([0,200]);

subplot(3,1,3);
[pxx1,w1] = periodogram(a1);
[pxx2,w2] = periodogram(simulated_noises(num,:));
[pxx3,w3] = periodogram(simulated_impulse(num,:));
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
% % ylim([-100,100]);

 
 
 
