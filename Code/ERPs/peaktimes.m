%%%% NOTE: this project was provided blank with just the following instruction.
%%%% I added more plots to inspect the data and try new plotting features

%%
%     COURSE: Solved problems in neural time series analysis
%    SECTION: Time-domain analyses
%      VIDEO: Project 2-2: ERP peak latency topoplot
% Instructor: sincxpress.com
%
%%

%% Loop through each channel and find the peak time of the ERP between 100 and 400 ms. 
%   Store these peak times in a separate variable, and then make a
%   topographical plot of the peak times. Repeat for a low-pass filtered ERP.


%%%%





load sampleEEGdata.mat

%%

% Set time-window-parameters
win = [100 400];

% Find time-point for window
tloc = []
for i = 1:length(win)
  
  [~, loc] = min(abs(EEG.times - win(i)));
  tloc(i) = loc;
  
end 

% Compute ERPs
erp = double(mean(EEG.data(:, :, :), 3));


% Check erps for one channel
channels = {"T8", "C2"};

chanpos1 = strcmpi({EEG.chanlocs.labels}, channels(1));
chanpos2 = strcmpi({EEG.chanlocs.labels}, channels(2));

figure(1)

subplot(211)
plot(EEG.times, erp(chanpos1, :))
ylim = get(gca, "ylim")
x = [EEG.times(tloc(1)) EEG.times(tloc(1)) EEG.times(tloc(2)) EEG.times(tloc(2))]
ptch = patch(x, ylim([1 2 2 1]),'g', "facealpha", 0.5, "edgecolor", "none")
title("ERP from channel T8")
xlabel("Time (ms)")
ylabel("Amplitude")

subplot(212)
plot(EEG.times, erp(chanpos2, :))
ylim = get(gca, "ylim")
x = [EEG.times(tloc(1)) EEG.times(tloc(1)) EEG.times(tloc(2)) EEG.times(tloc(2))]
ptch = patch(x, ylim([1 2 2 1]),'g', "facealpha", 0.5, "edgecolor", "none")
title("ERP from channel C2")
xlabel("Time (ms)")
ylabel("Amplitude")



% Find peak time for each channel

% Initialize empty matrix to store peak times
tpeak = zeros(EEG.nbchan, 1);

% Find peak times and store them in tpeak

for rep = 1:EEG.nbchan
  
  [~, maxpeak] = max(erp(rep, tloc(1):tloc(2)));
  tpeak(rep, 1) = EEG.times(tloc(1) + maxpeak);
  
end 
