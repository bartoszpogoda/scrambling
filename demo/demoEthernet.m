addpath(genpath('model'));
addpath(genpath('helper'));

% demo Ethernet
ethernetCoder = EthernetCoder();

% parameters
signalSize = 113;

% create a random signal
signal = Signal(signalSize);
for i = 1 : signalSize 
    if round(rand())
        signal.setBit(i);
    end
end

% append zeroes to match ethernet 64-bit framing
signal = Helper.appendToAlign64(signal);

% encoding demo
disp("Signal before encoding:");
signal.disp();
fprintf("Size: %d \n", signal.getSize());

signal = ethernetCoder.encode(signal);

disp("Signal after encoding:");
signal.disp();
fprintf("Size: %d \n", signal.getSize());
