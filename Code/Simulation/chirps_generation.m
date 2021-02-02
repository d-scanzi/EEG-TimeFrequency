% Simulating Chirps with random oscillations, from a gaussian and from a exponential

% Setting reading parameters
srate_chirps = 1048;
sec_chirps = 10;
pnts_chirps = srate_chirps * sec_chirps;
time_chirps = (0:pnts_chirps-1)/srate_chirps;

% Random Oscillation
nbpoles_chirps = 8;

% creating vector of frequqncies without summing them
freqrand = interp1(randn(1, nbpoles_chirps), linspace(1, nbpoles_chirps, pnts_chirps)); 

%create signal. Note: the sum of frequqncies is done here. Frequqncies are then divided by sampling rate
signal_random = sin(2*pi*(cumsum(freqrand)/srate_chirps + time_chirps)); 

% Gaussian-driven chirps signal

% Setting gaussian parameters
gaussampl_chirps = 2.5;
gausspkt_chirps = 1.5;
fwhm_chirps = 0.47;

% Creating gaussian wave and signal from it
freqgauss = gaussampl_chirps * exp((-4*log(2)*(time_chirps - gausspkt_chirps).^2)/(fwhm_chirps^2));
signal_gauss = sin(2*pi*(cumsum(freqgauss)/srate_chirps + time_chirps));

% Exponential-drive chirps
expampl_chirps = 1;

freqexp = expampl_chirps * 1.5.^(time_chirps);
signal_log = sin(2*pi*(cumsum(freqexp)/srate_chirps + time_chirps));


% Plotting
freqmod = [freqrand; freqgauss; freqexp];
sigmod = [signal_random; signal_gauss; signal_log];

for fig = 1:size(freqmod, 1)

    figure(fig)
    
    subplot(211)
    plot(time_chirps, freqmod(fig, :), "g", "linewidth", 5)
    xlabel("Time (s)")
    ylabel("Frequqncy (Hz)")
    
    subplot(212)
    plot(time_chirps, sigmod(fig, :))
    xlabel("Time (s)")
    ylabel("Amplitude")
    
end
