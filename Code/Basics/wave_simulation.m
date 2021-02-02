%% Simulating Sine, Gaussian and Euler's Identity waves

% Simulating sine waves with multiple amplitdues/phases/frequencies


% Setting wave parameters
alpha = [ 2 5 8 10 13 ];
theta = [ 0 2/pi pi/3 -3 -pi/2 ];
freq = [ 2 4 6 8 10 ];

% Setting reading parameters
seconds = 10;
srate = 240;%Hz
pnts = srate * seconds;

times = [0:pnts-1]/srate;

% Initialize sinewave matrix
sinwaves = zeros(length(freq), length(times));

% Creating waves - fillling up the matrix
for n = 1:length(freq)
  sinwaves(n, :) = alpha(n) * sin(2 * pi * freq(n) * times + theta(n));
endfor

% Plotting sinewaves
colors = [ "r", "b", "g", "y", "m"];

figure(1)
for n = 1:length(freq)
  subplot(length(freq), 1, n)
  plot(times, sinwaves(n, :), "color", colors(n))
endfor


% Simulating gaussian waves with multiple peak times, full-width half-maximum, amplitude

% Setting gaussian parameters
peak_time = [ 1 2 3 4 5 ];
peak_ampl = [ 0.5 3 5 -2 -3];
fwhm = [ 0.3 0.5 0.7 0.99 0.2 ];

% Setting reading parameters
gaus_srate = 480; %Hz
gauss_times = -5:1/gaus_srate:10;

% Initialze gaussian waves matrix
gaussians = zeros(length(peak_time), length(gauss_times));

% Creating gaussians - filling up gaussian matrix
for n = 1:length(peak_time)
  gaussians(n, :) = peak_ampl(n)*exp((-4*log(2)*(gauss_times - peak_time(n)).^2)/fwhm(n)^2);
endfor

% Plotting Gaussians

fig(2)
for n = 1:length(peak_time)
  subplot(length(peak_time), 1, n)
  plot(gauss_times, gaussians(n, :), "color", colors(n)) 
  axis([0, 10])
endfor

% Simulating Euler's Identity

% Swetting the identity parameters

M = [ 1 3 5 7 9 -3 ]
k = [ pi/4 pi/2 pi 3*pi -pi/2 pi*2]

% Initializing euler's matrix
eulers = zeros(length(M), length(k))

% Plotting complex vectors described by euler's identity
eulers_color = [ "r", "b", "g", "y", "m", "c"];
figure(3)
for n = 1:length(M)
  subplot(length(M), 2, n)
  polar([0 k(n)], [0 M(n)], "color", eulers_color(n))
endfor



