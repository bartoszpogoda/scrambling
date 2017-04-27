addpath(genpath('model'));
addpath(genpath('helper'));

% parameters
signalSize = 113;
desyncAt = 12; % less than signalSize!!

% create 2 random signals
signal = Signal(signalSize);
signal2 = Signal(signalSize);
for i = 1 : signalSize 
    if round(rand())
        signal.setBit(i);
        signal2.setBit(i);
    end
end

% BER test
disp("BER of signal with itself: ");
disp(Helper.calculateBER(signal,signal));

% negate one bit
signal2.negBit(signalSize);

% BER test
disp("BER of signals with 1 bit difference: ");
disp(Helper.calculateBER(signal,signal2));
disp("1 bit : signalSize: ");
disp(1/signalSize);




