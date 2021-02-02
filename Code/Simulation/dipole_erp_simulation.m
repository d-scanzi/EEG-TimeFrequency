%% Simulating ERPs in dipoles

% Loading data
load emptyEEG

% Selecting dipoles
dipole1 = 403;
dipole2 = 525;

% Plotting dipoles and dipole1/2 location
figure(1)
plot3(lf.GridLoc(:,1), lf.GridLoc(:,2), lf.GridLoc(:,3), "bo", "markerfacecolor", "b")
hold on
plot3(lf.GridLoc(dipole1,1),lf.GridLoc(dipole1,2),lf.GridLoc(dipole1,3), "ro", "markerfacecolor", "r", "markersize", 10 )
plot3(lf.GridLoc(dipole2,1),lf.GridLoc(dipole2,2),lf.GridLoc(dipole2,3), "go", "markerfacecolor", "g", "markersize", 10 )
rotate3d on, axis square
title("Dipoles Location")

% Scaling the data
EEG.pnts = 2000;
EEG.times = (0:EEG.pnts-1)/EEG.srate;
EEG.trials = 68;

% Initialize EEG.data
EEG.data = zeros(EEG.nbchan, EEG.pnts, EEG.trials);

%% Simulating dipoles data and projecting it onto scalp
%% using forward model

% Changing Frequency for dipole1 (chirps)
freqmod = 7*interp1(randn(1, 15), linspace(1, 15, EEG.pnts));
chirp = sin(2*pi + cumsum(freqmod)/EEG.srate);

for triali = 1:EEG.trials
  
  % Creating dipole activity matrix
  dipoleact = .04 *randn(size(lf.Gain, 3), EEG.pnts);
  
  % Simulating dipole1 activity
  fwhm = 0.9;
  gauss = exp((-4*log(2)*(EEG.times - 0.5).^2)/fwhm^2);
  dipoleact(dipole1, :) = chirp .* gauss;
  
  % Simulating dipole2 activity
  fwhm = 0.2;
  gauss = exp((-4*log(2)*(EEG.times-0.5).^2)/fwhm^2);
  dipoleact(dipole2, :) = gauss;
  
  % Populating EEG.data through forward model
  EEG.data(:, :, triali) = squeeze(lf.Gain(:, 1, :)) * dipoleact;
  
end

% Plotting
plot_simEEG(EEG,31,2)
plot_simEEG(EEG,23,3)

plot(EEG.times, dipoleact(dipole1, :))
