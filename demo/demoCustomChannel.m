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
customChannel.addSingleError(1);
customChannel.addSingleError(signalSize);
customChannel.addSingleError(2);

disp("Error channel state: " + customChannel.singleErrorsToString());

customChannel.deleteSingleError(2);

disp("Error channel state: " + customChannel.singleErrorsToString());

% receive
signalReceiver = customChannel.receive();
disp("Value at receiver's side: " + signalReceiver.toString());
disp(" ");

% errors from array
customChannel.setSingleErrors([1;2;3]);
disp("Error channel state: " + customChannel.singleErrorsToString());

  