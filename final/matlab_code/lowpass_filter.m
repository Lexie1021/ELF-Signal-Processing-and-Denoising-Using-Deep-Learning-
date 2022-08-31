
clc
clear
close all;
 
%% Generate noise
Fs = 512; 
T=1/Fs;                  
L=512;
t=(0:L-1)*T;             
noise1 = wgn(Fs,1,0,'real');
figure(1)
subplot(211)
plot(t,noise1)
grid on
xlabel('Time/s'); 
ylabel('Amplitude') 
title('Time Domain')
 
% Fourier transform

NFFT=L;
Y=fft(noise1,NFFT)/L;             
f=Fs/2*linspace(0,1,NFFT/2+1);

subplot(212)
plot(f,2*abs(Y(1:NFFT/2+1)))  
xlabel('Frequency(Hz)'); 
ylabel('Amplitude') 
title('Frequency Domain')
ylim([0,250]);
grid on
 
%% Digital LFP
fn=1024;
fp=80;  
fs=150;  
Rp=3;  
Rs=30;
Wp=fp/(fn/2); % normalized frequency??
Ws=fs/(fn/2);
[n,Wn]=buttord(Wp,Ws,Rp,Rs);% Calculated order and cut frequency
[b,a]=butter(n,Wn);         % Calculated H(z), the parameter of numerator and denominator
[H,F]=freqz(b,a,NFFT/2+1,1002);      % Calculated impulse response of H(z)
figure(2)
subplot(211)
plot(F,20*log10(abs(H))) 
xlabel('Frequency(Hz)'); ylabel('Amplitude(dB)') 
title('Lowpass Filter')
axis([0 150 -30 3]);
grid on
subplot(212)
pha=angle(H)*180/pi;
plot(F,pha);
xlabel('Frequency(Hz)'); ylabel('Phase')
title('Phase of Lowpass Filter')
grid on
 
%filter out the high frequnecy component
figure(4)
A=2*abs(Y(1:NFFT/2+1)).*(abs(H));
plot(f,A)  
xlabel('Frequency(Hz)'); ylabel('Amplitude')
title('Fiter out the high frequency component of the noise')
grid on
 
%% ifft
p = NFFT/2+1;
A = A';
for i=1:L-p
A(1,(p+i))=A(1,(p-i));
end
 
z=A'.*exp(1i*angle(Y));
z2=real(ifft(z));
figure(3)
subplot(2,1,1)
n = z2*NFFT/2;
% plot(t,noise1);
plot(f,2*abs(Y(1:NFFT/2+1)))  
grid on;
xlabel('Frequency(Hz)'); 
ylabel('Amplitude') 
title('Original simulated noise signal (frequency domain)')
xlim([0,250]);
subplot(2,1,2)
Y1=fft(n,NFFT)/L;             
f=Fs/2*linspace(0,1,NFFT/2+1);
plot(f,2*abs(Y1(1:NFFT/2+1)));
xlim([0,250]);
grid on;
xlabel('Frequency(Hz)'); 
ylabel('Amplitude') 
title('Filtered noise signal (frequency domain)')

 
 
 
