%%% Creating a noisy signal adding multiple sine waves together and retreiving the components with a fourier transformation
%   Done with both for-looping transformation and ftt() function.


%% Creating the signal

% sine parameters
freqs = [1.5 3 5 7.5 9 15];
phs = [0 2*pi pi/2 pi/3 pi*3 3/4*pi 2/3*pi];
ampls = [2 12 4 10 6 8];

% reading parameters
srate = 1048; %Hz
times = 0:1/srate:3;
pnts = length(times); 

% signal
sig = zeros(1, pnts);

for fi = 1:length(freqs)
  
  sig(1, :) = sig(1, :) + (ampls(fi) * sin(2*pi*freqs(fi)*times + phs(fi)));
  
end

% Implementing fourier transformation using a for-loop
ftimes = (0:pnts -1)/pnts;
nyquist =  srate/2;

fcoef = zeros(size(sig));

for i = 1:pnts
  
  csw = exp(-1i*2*pi*(i - 1)*ftimes);
  fcoef(1, i) = sum(csw.*sig);
  
end

% Possible frequencies
fhz = linspace(0, nyquist, (pnts/2) + 1);

% Extracting and normalising amplitudes
extr_amp = 2 * abs(fcoef / pnts);


% Using built-in fourier transformation
fftcoef = fft(sig);
fftamp = 2*abs(fftcoef / pnts);



%% Trying adding some noise to see if it affects the fourier transformation
%  Same as before, just with noise

fcoef_noise = zeros(size(sig));
% Adding noise
noise = randn(1, pnts) * 10;
sig_noisy = sig + noise;

for i = 1:pnts
  
  csw = exp(-1i*2*pi*(i - 1)*ftimes);
  fcoef_noise(1, i) = sum(csw.*sig_noisy);
  
end


% Extracting and normalising amplitudes
extr_amp_noise = 2 * abs(fcoef_noise / pnts);


% Using built-in fourier transformation
fftcoef_noise = fft(sig_noisy);
fftamp_noise = 2*abs(fftcoef_noise / pnts);


% Plotting

figure(1)

% Plotting Signal without noise
subplot(321)
plot(times, sig, "LineWidth", 2)
xlabel("Time (ms)")
ylabel("Amplitude")
title("Simulated signal")
grid on

% Plotting result of for-loop fourier transformation without noise
subplot(323)
stem(fhz, extr_amp(1:length(fhz)), "k", "MarkerFaceColor", "red", "MarkerEdgeColor", "red")
set(gca, "xlim", [0 20])
xticks(-1:2:20)
xlabel("Frequencies")
ylabel("amplitudes")
title("For-Loop fourier transformation")
grid on

% Plotting results from built-in function without noise
subplot(325)
stem(fhz, fftamp(1:length(fhz)), "k", "MarkerFaceColor", "green", "MarkerEdgeColor", "green")
set(gca, "xlim", [0 20])
xticks(-1:2:20)
xlabel("Frequencies")
ylabel("amplitudes")
title("Built-in fourier transformation")
grid on

% Plotting Signal with noise
subplot(322)
plot(times, sig_noisy, "LineWidth", 2)
xlabel("Time (ms)")
ylabel("Amplitude")
title("Simulated signal with noise")
grid on

% Plotting result of for-loop fourier transformation with noise
subplot(324)
stem(fhz, extr_amp_noise(1:length(fhz)), "k", "MarkerFaceColor", "red", "MarkerEdgeColor", "red")
set(gca, "xlim", [0 20])
xticks(-1:2:20)
xlabel("Frequencies")
ylabel("amplitudes")
title("For-Loop fourier transformation with noise")
grid on

% Plotting results from built-in function with noise
subplot(326)
stem(fhz, fftamp_noise(1:length(fhz)), "k", "MarkerFaceColor", "green", "MarkerEdgeColor", "green")
set(gca, "xlim", [0 20])
xticks(-1:2:20)
xlabel("Frequencies")
ylabel("amplitudes")
title("Built-in fourier transformation with noise")
grid on
