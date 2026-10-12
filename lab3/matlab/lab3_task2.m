% eeg_artefact_suppression_task2.m
clear; close all; clc;

% Load the dataset
load('eeg_artefact_data.mat');
x = x_measured(:);
v1 = v1(:);
N = length(x);

% Welch parameters based on Lab Task 1
window_length = 256;
overlap = round(0.5 * window_length);
nfft = 1024;

%% Initial Plots
figure;
subplot(2,1,1); plot(x); title('Measured EEG (x)');
subplot(2,1,2); plot(v1); title('EOG Reference (v1)');

figure;
% Applying Task 1 pwelch parameters
[psd_x, f] = pwelch(x, window_length, overlap, nfft, 1);
plot(f, 10*log10(psd_x), 'LineWidth', 1.2);
title('Spectrum of x(n)');
xlabel('Normalized Frequency (\times\pi rad/sample)');
ylabel('Power/frequency (dB/(rad/sample))');
grid on;

%% Sub-task 1: Fixed w
% Computes Least Squares estimate to minimize MSE
w_fixed = (x' * v1) / (v1' * v1);
s_hat_fixed = x - w_fixed * v1;

fprintf('Fixed w estimate: %f\n', w_fixed);
figure;
plot(s_hat_fixed); 
% FIX: Removed TeX formatting (\hat{}) to resolve the SceneNode interpreter error
title(sprintf('Fixed Estimate s-hat(n), w-hat = %.4f', w_fixed)); 

%% Sub-task 2: Time-varying LMS
mu_lms = 1e-5; 
[s_hat_lms, w_lms, w_traj_lms] = my_lms_artefact_canceller(x, v1, mu_lms);

c_lms = (s_hat_lms' * v1 / N) / (sqrt(var(s_hat_lms)) * sqrt(var(v1)));
fprintf('LMS Correlation c: %f\n', c_lms);

figure;
subplot(3,1,1); 
plot(s_hat_lms); 
title(sprintf('LMS Estimated Brain Signal (\\mu = %g)', mu_lms));

subplot(3,1,2); 
plot(w_traj_lms); 
title('LMS Weight Trajectory');

subplot(3,1,3); 
% Applying Task 1 pwelch parameters to LMS estimate
[psd_s_lms, f_lms] = pwelch(s_hat_lms, window_length, overlap, nfft, 1);
plot(f_lms, 10*log10(psd_s_lms), 'LineWidth', 1.2); 
title('Spectrum of LMS Estimate s-hat(n)');
xlabel('Normalized Frequency'); ylabel('PSD (dB)'); grid on;

%% Sub-task 2: Normalized LMS (NLMS)
mu_nlms = 0.05; 
epsilon = 1e-6; 
s_hat_nlms = zeros(N, 1);
w_traj_nlms = zeros(N, 1);
w_n = 0;

for n = 1:N
    s_hat_nlms(n) = x(n) - w_n * v1(n);
    w_traj_nlms(n) = w_n;
    % Normalization by reference signal power prevents instability
    w_n = w_n + mu_nlms * s_hat_nlms(n) * v1(n) / (v1(n)^2 + epsilon);
end

c_nlms = (s_hat_nlms' * v1 / N) / (sqrt(var(s_hat_nlms)) * sqrt(var(v1)));
fprintf('NLMS Correlation c: %f\n', c_nlms);

figure;
subplot(3,1,1); 
plot(s_hat_nlms); 
title(sprintf('NLMS Estimated Brain Signal (\\mu = %g)', mu_nlms));

subplot(3,1,2); 
plot(w_traj_nlms); 
title('NLMS Weight Trajectory');

subplot(3,1,3); 
% Applying Task 1 pwelch parameters to NLMS estimate
[psd_s_nlms, f_nlms] = pwelch(s_hat_nlms, window_length, overlap, nfft, 1);
plot(f_nlms, 10*log10(psd_s_nlms), 'LineWidth', 1.2); 
title('Spectrum of NLMS Estimate s-hat(n)');
xlabel('Normalized Frequency'); ylabel('PSD (dB)'); grid on;