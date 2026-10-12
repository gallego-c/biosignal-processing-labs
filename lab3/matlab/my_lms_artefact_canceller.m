function [s_hat,w,w_trajectory] = my_lms_artefact_canceller(x,v1,mu)
%
% Here you should implement an LMS filter as to estimate the signal of
% interest s from the equation
%
%   x(n) = s(n) + v0(n), n = 1,2,...,N,
%
% where v0(n) is an unknown interference. Here, you will model this as
%
%   x(n) = s(n) + w(n)v1(n) , n = 1,2,...,N,
%
% where v1(n), n = 1,2,...,N, is a known reference signal, and
% w(n), n = 1,2,...,N, is an unknown weighting (called filter) to be
% estimated.
%
% You should output an estimate of s(n), for n = 1,2,...,N, as well as an
% estimate of the filter trajectory, i.e., w(n) for n = 1,2,...N.
%
%
%
% INPUT
% x             -   the measured signal (vector of length N).
% v1            -   reference signal to be cancelled (vector of length N).
% mu            -   stepsize of the LMS filter (positive scalar).
%
% OUTPUT
% s_hat         -   estimate of the signal of interest (vector of length N).
% w             -   final estimate of filter coefficient (scalar)
% w_trajectory  -   the trajectory of the filter coefficients, i.e., the
%                   sequence w(n) for n = 1,2,...,N. (vector of length N).
%
%

    % Number of samples
    N = length(x);

    % Initialization
    s_hat = zeros(size(x));
    w_trajectory = zeros(size(x));
    w = 0;

    % Algorithm
    for n = 1:N

        % Compute instantaneous error or s_hat
        s_hat(n) = x(n) - w * v1(n); 

        % Store and update weights
        w_trajectory(n) = w;
        w = w + mu * s_hat(n) * v1(n);

    end

end