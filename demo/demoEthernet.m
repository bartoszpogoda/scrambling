addpath(genpath('model'));
addpath(genpath('helper'));

% demo Ethernet
ethernetCoder = EthernetCoder();
ethernetDecoder = EthernetDecoder();

% parameters
signalSize = 113;
desyncAt = 12; % less than signalSize!!

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

% decoding demo

signal = ethernetDecoder.decode(signal);

disp("Signal after decoding:");
signal.disp();
fprintf("Size: %d \n", signal.getSize());
fprintf("Was good: %d  Bad preamble at frame %d \n", ethernetDecoder.wasGood(), ethernetDecoder.badFrame());

% SYNC-LOSS SIMULATION

disp(" ");
disp("Sync loss simulation: ");
disp(" ");

% encoding demo
disp("Signal before encoding:");
signal.disp();
fprintf("Size: %d \n", signal.getSize());

signal = ethernetCoder.encode(signal);

disp("Signal after encoding:");
signal.disp();
fprintf("Size: %d \n", signal.getSize());

% doubling bit at desyncAt index
newSignal = Signal(signal.getSize() + 1);
for i = 1 : desyncAt
    newSignal.setBitV(i, signal.getBit(i));
end
newSignal.setBitV(desyncAt + 1, newSignal.getBit(desyncAt));
for i = desyncAt + 2 : newSignal.getSize()
    newSignal.setBitV(i, signal.getBit(i-1));
end
signal = newSignal;

disp("Signal after desync:");
signal.disp();
fprintf("Size: %d \n", signal.getSize());


signal = ethernetDecoder.decode(signal);

disp("Signal after decoding:");
signal.disp();
fprintf("Size: %d \n", signal.getSize());
fprintf("Was good: %d  Bad preamble at frame %d \n", ethernetDecoder.wasGood(), ethernetDecoder.badFrame());


