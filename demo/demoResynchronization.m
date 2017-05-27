addpath(genpath('model'));
addpath(genpath('helper'));

ethernetDecoder = EthernetDecoder();

% create a random signal
signal = Helper.randSignal(128 + 4);
signal.clearBit(1);
signal.setBit(2);
signal.insertBit(0,0);

signal.clearBit(67);
signal.setBit(68);

signal.clearBit(6);
signal.setBit(7);

disp("Signal before decoding:");
signal.disp();

ethernetDecoder.checkForPreambleInRange(signal,6)

signal = ethernetDecoder.decode(signal);

disp("Signal after decoding:");
signal.disp();


