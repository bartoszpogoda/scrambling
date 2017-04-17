    addpath(genpath('model'));

% demo Ethernet
ethernetCoder = EthernetCoder();

% parameters
signalSize = 128;

% create a random signal
signal = Signal(signalSize);
for i = 1 : signalSize 
    if round(rand())
        signal.setBit(i);
    end
end

% encoding demo
disp("Signal before encoding:");
signal.disp();

encodedSignal = ethernetCoder.encode(signal);

disp("Signal after encoding:");
encodedSignal.disp();
