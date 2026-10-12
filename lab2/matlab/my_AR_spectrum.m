function [Phi,freq_grid] = my_AR_spectrum(x,P,fs,freq_grid)
%
% INPUT
% x         -       vector of length N.
% P         -       AR-order. Note: this must be an integer.
% freq_grid -       vector of frequencies (in Hz) at which the spectrum
%                   will be computed.
% fs        -       sample frequency (in Hz). Default is 1.
%
% OUTPUT
% Phi       -       estimate of the power spectral density. This is a
%                   vector of the same length as freq_grid.
% freq_grid -       vector of frequencues (Hz) at which Phi is computed.
%                   This is the same as the input freq_grid.
%
% Example usage: 
% Let x be a vector of length N. 
%

x = x(:);

if nargin<4 || isempty(freq_grid)
    if nargin<3 || isempty(fs)
        fs = 1;
    end
    N_freq = 1e4;
    freq_grid = linspace(0,fs/2,N_freq)';
end
freq_grid = freq_grid(:);
if max(freq_grid)>fs/2
    error('The maximum allowed frequency is fs/2')
end

ar_pol = aryule(x,P);
%ar_pol = arburg(x,P);
%ar_pol = arcov(x,P);
sigma2_est = var(filter(ar_pol,1,x));

omega_grid = 2*pi*freq_grid/fs;

freq_mat = exp(1i*(0:P)'*omega_grid');

Phi = sigma2_est./abs(ar_pol(:)'*freq_mat).^2;
Phi = Phi(:);
end

