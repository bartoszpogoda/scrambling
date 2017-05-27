addpath(genpath('view'));
addpath(genpath('model'));
addpath(genpath('helper'));

randomSignalSize = 6400;
testIterations = 100;

summaricBERWithoutEthernet = 0;
summaricBERWithEthernet = 0;
summaricBERWithScrambling = 0;

encoder = EthernetCoder();
decoder = EthernetDecoder();

scrambler = Scrambler();
descrambler = Descrambler();

channel = CustomChannel();
channel.desyncBreakpoint = 10;  
channel.desyncType = 1;

for i = 1 : testIterations 
    signal = Helper.randSignal(randomSignalSize);
    
    channel.send(signal);
    receivedNoEnc = channel.receive();
    
    summaricBERWithoutEthernet = summaricBERWithoutEthernet + Helper.calculateBER(signal, receivedNoEnc);
    
    encoded = encoder.encode(signal);
    channel.send(encoded);
    receivedEncC = channel.receive();
    receivedEnc = decoder.decode(receivedEncC);
    
    summaricBERWithEthernet = summaricBERWithEthernet + Helper.calculateBER(signal, receivedEnc);
    
    scrambler.resetLFSR();
    descrambler.resetLFSR();
    
    scrambled = scrambler.scramble(signal.copy());
    encoded = encoder.encode(scrambled);
    channel.send(encoded);
    receivedEncC = channel.receive();
    receivedEnc = decoder.decode(receivedEncC);
    descrambled = descrambler.descramble(receivedEnc);
    
    summaricBERWithScrambling = summaricBERWithScrambling + Helper.calculateBER(signal, descrambled);
    
end

summaricBERWithEthernet = summaricBERWithEthernet/testIterations;
summaricBERWithoutEthernet = summaricBERWithoutEthernet/testIterations;
summaricBERWithScrambling = summaricBERWithScrambling/testIterations;
disp("With Ethernet: ");
disp(summaricBERWithEthernet);
disp("Without Ethernet: ");
disp(summaricBERWithoutEthernet);
disp("With Ethernet and Scrambling: ");
disp(summaricBERWithScrambling);