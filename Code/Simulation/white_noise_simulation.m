%% Simulating white noise 

% Setting EEG paramteres
EEG.nbchan = 64;
EEG.trials = 98;

% Setting reading parameters
trial_seconds = 7;
EEG.srate = 480; %Hz
EEG.pnts = EEG.srate * trial_seconds;

EEG.times = (0:EEG.pnts-1)/EEG.srate;

% Creating noise data from normal distribution
EEG.datan = randn(EEG.nbchan, EEG.pnts, EEG.trials);

% Creating noise data from uniformal distribution
EEG.data = rand(EEG.nbchan, EEG.pnts, EEG.trials);

% Plottoing ERPs from first 5 channels from normally distributed noise
figure(1)
for i = 1:5
  subplot(5, 1, i)
  plot(EEG.times, mean(EEG.datan(i, :, :),3))
  title(["Channel " num2str(i)])
endfor

% % Plottoing ERPs from first 5 channels from uniformally distributed noise
figure(2)
for i = 1:5
  subplot(5, 1, i)
  plot(EEG.times, mean(EEG.data(i, :, :),3))
  title(["Channel " num2str(i)])
endfor
