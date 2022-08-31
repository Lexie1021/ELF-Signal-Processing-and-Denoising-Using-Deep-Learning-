% Yiqing wang
% 02066717

close all;
clf;

fs = 512;
f0 = 7.83;
t = 0:1/fs:1-1/fs;
d = 0:1/f0:1;   
x = tripuls(t,0.01,-1);
simulated_impulse = zeros(3000,512);
for i = 0:3000-1
    i = i+1;
    a = rand+0.2;
    simulated_impulse(i,:) = 6*a*pulstran(t,d,x,fs); 
    % Make sure the amplitude of the impulse will not be too low
end
save simulated_impulse.mat;

b = 0;
simulated_sin = zeros(3000,512);

for b = 0:3000-1
    b = b+1;
    a = rand+0.2;
    simulated_sin(b,:) = 3*a*sin(2*pi*f0*t);
end
save simulated_sin.mat;
% plot figure--------------------------------------------------------
figure(1);
B = simulated_sin';
A = reshape(B,[],1);
s = 4096;
subplot(3,1,1);
plot(t,A(1:512));
title('Simulated impulse signal (time domain)');
xlabel('Time/s');
ylabel('Amplitude');
grid on;


Y=fft(A(1:s));
L = s;
P2 = abs(Y/L);
P1 = P2(1:L/2+1);
P1(2:end-1) = 2*P1(2:end-1);
subplot(3,1,2);
f = fs*(0:(L/2))/L;
plot(f,P1);
grid on;
title('Simulated impulse signal (frequency domain)');
xlabel('Frequency/Hz');
ylabel('Amplitude');
xlim([0,150]);

subplot(3,1,3)
[pxx,w] = periodogram(A(1:s));
plot(w,10*log10(pxx));
grid on;
xlabel('Normalized Frequency(rad/sample)');
ylabel('Power/Frequency(dB/(rad/sample))')
title('Power Spectral Density Estimate ')

