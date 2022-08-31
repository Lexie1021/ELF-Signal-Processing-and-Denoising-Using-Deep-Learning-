load received_impulse.mat;
load received_impulse2.mat;
load received_sin.mat;
load received_noise2.mat;
load impulse_noise1_2.mat;
load impulse_noise2_2.mat;
load sin_noise_2.mat;

plot(received_sin(1,:));
title('Received sin signal of 1 second');
xlabel('sample');
ylabel('Amplitude');
grid on;
impulse_received  = received_impulse./300;
impulse2_received = received_impulse2./300;
sin_received = received_sin./389;
noise_received = received_noise2./389;
noise_impulse1 = impulse_noise1_2./300;
noise_impulse2 = impulse_noise2_2./300;
noise_sin = sin_noise_2./389;

% save E:\master\final_project\dataset\received_sig\impulse_received.mat;
save  E:\master\final_project\dataset\received_sig\impulse2_received.mat;
save  E:\master\final_project\dataset\received_sig\sin_received.mat;
save  E:\master\final_project\dataset\received_sig\noise_received.mat;
% save E:\master\final_project\dataset\received_sig_with_noisenoise_impulse1.mat;
save E:\master\final_project\dataset\received_sig_with_noise\noise_impulse2.mat;
save E:\master\final_project\dataset\received_sig_with_noise\noise_sin.mat;
