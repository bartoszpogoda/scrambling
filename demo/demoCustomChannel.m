addpath(genpath('model'));
addpath(genpath('helper'));

% parameters
signalSize = 64;

customChannel = CustomChannel;                % create custom channel 
signalSender = Helper.randSignal(signalSize); % create signal

disp("Value at sender's side: " + signalSender.toString());

% send
customChannel.send(signalSender);

% add errors on the first and the last bits of signal
customChannel.singleErrors = [1; signalSize];


disp("Error channel state: " + customChannel.singleErrorsToString());

% receive
signalReceiver = customChannel.receive();
disp("Value at receiver's side: " + signalReceiver.toString());
disp(" ");

% errors from array
customChannel.singleErrors = [1; 2; 3];
disp("Error channel state: " + customChannel.singleErrorsToString());

% desync test


disp(" ");
disp("Desync Test: ")

rSignal = Helper.randSignal(16); % create signal
disp("Signal at sender's side: " + rSignal.toString());

customChannel = CustomChannel();
customChannel.desyncType = -1;
% customChannel.desyncType = 1;
customChannel.desyncBreakpoint = 3;

customChannel.send(rSignal);
rSignal = customChannel.receive();

disp("Signal at receiver's side: " + rSignal.toString());

  