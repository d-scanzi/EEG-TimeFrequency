% set up environment
struct_levels_to_print(0);

% Load file
load emptyEEG

% Select dipole
dipole_n = 476;

% Display dipole grid and selected dipole
figure(1)
plot3(lf.GridLoc(:, 1), lf.GridLoc(:, 2), lf.GridLoc(:, 3), "co", "markersize", 5, "markerfacecolor", "c")
hold on
plot3(lf.GridLoc(dipole_n, 1), lf.GridLoc(dipole_n, 2), lf.GridLoc(dipole_n, 3), "ro", "markersize", 10, "markerfacecolor", "r")
title("Dipoles position and Selected dipole")
rotate3d on, axis square


% Resizing EEG parameters and setting number of trials
EEG.pnts = 2000; 
EEG.times = (0:EEG.pnts -1)/EEG.srate;
EEG.trials = 35;

% Creating transient signal for chosen dipole
dipamp = 2.4;
dippktime = 2.3;
dipfwhm = 0.76; 

dipsignal = dipamp * exp((-4*log(2)*(EEG.times - dippktime).^2)/(dipfwhm)^2);

% Creating noise signal as non-stationary signal
nbpoles = 10;
freqmod = 20*interp1(randn(1, nbpoles), linspace(1, nbpoles, EEG.pnts));
noise_signal = sin(2*pi*(cumsum(freqmod)/EEG.srate + EEG.times));

figure(2)

% Display noise signal chirps
subplot(211)
plot(EEG.times, freqmod, "r")
xlabel("Time (s)")
ylabel("Frequency (Hz)")

subplot(212)
plot(EEG.times, noise_signal)

% Create a dipole signal matrix
dipole_signal = zeros(size(lf.Gain, 3), EEG.pnts);

% Creating varying non-stationary signals for each dipole
for dipoli = 1:size(lf.Gain, 3)
  
  nbpoles = 10;
  freqmod = 20*interp1(randn(1, nbpoles), linspace(1, nbpoles, EEG.pnts));
  noise_signal = sin(2*pi*(cumsum(freqmod)/EEG.srate + EEG.times));
  
  dipole_signal(dipoli, :) = noise_signal;
end

% Introducing transient signal in chosen dipole
dipole_signal(dipole_n, :) = dipsignal;

% Projecting dipole signal onto scalp (simulating recording)

% Initializing EEG data matrix
EEG.data = zeros(EEG.nbchan, EEG.pnts, EEG.trials);

for triali = 1:EEG.trials
  
  EEG.data(:, :, triali) = squeeze(lf.Gain(:, 1, :)) * dipole_signal;
end

% Plot readings from two channels
plot_simEEG(EEG, 35, 3)
plot_simEEG(EEG, 40, 4)





