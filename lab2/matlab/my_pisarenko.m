function [Phi,f] = my_pisarenko(x,P,fs)
% 
% INPUT
% x         -       the signal (vector)
% P         -       number of sinusoids to be estimated (integer). This is
%                   the same as the number of spectral lines.
% fs        -       sampling frequencies.
%
% OUTPUT
% Phi       -       the spectrum. Note that this is a line spectrum, i.e., 
%                   i.e., only supported in a few points (i.e., the
%                   frequencies f below). When you plot this, use them
%                   "stem" command, i.e., stem(f,Phi).
% f         -       vector of frequencies where Phi is supported. The unit
%                   is Hz.
%

nbr_complex_roots = 2*P;
m = nbr_complex_roots+1;
xx = flipud(x);
N = length(xx);
nbr_windows = N-m+1;

% Compute sample covariance matrix
R = zeros(m,m);
for k_window = 1:nbr_windows
    xx_temp = xx(k_window +(0:m-1)');
    R = R + 1/N*(xx_temp*xx_temp');
end

% Compute eigenvalue decomposition and pick out eigenvector of smallest
% eigenvalue
[S,D] = eig(R);
[~,ind] = sort(diag(D),'ascend');
s = S(:,ind(1));

% The eigenvector define the coefficients of a polynomial. The frequencies
% (both positive and negative) are the roots of the polynomial
complex_roots = roots(s);

% These are all frequencies (positive and negative, in pairs)
all_freqs = sort(angle(complex_roots))/2/pi*fs;

% We only care about the positive ones.
f = all_freqs(P+1:end); % These are the frequencies of the sinusoids

%%%% Estimate amplitudes = spectrum %%%%%
% The covariance function is a sum of cosines. These amplitudes are in fact
% the "coefficients" of the spectral lines.

%We estimate the amplitudes by Least-Squares fitting.
r = covf(x,m); r = r(:);
A = cos((0:m-1)'*f'/fs*2*pi);
%A = cos((0:m)'*f'/fs*2*pi);
Phi = A\r; % Least squares.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

