addpath(genpath('view'));
addpath(genpath('model'));
addpath(genpath('helper'));

randomSignalSize = 12800;
testIterations = 100;

summaricBERWithoutEthernet = 0;
summaricBERWithEthernet = 0;

encoder = EthernetCoder();
decoder = EthernetDecoder();

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
end

%summaricBERWithEthernet = summaricBERWithEthernet/testIterations;
%summaricBERWithoutEthernet = summaricBERWithoutEthernet/testIterations;
disp("With: ");
disp(summaricBERWithEthernet);
disp("Without: ");
disp(summaricBERWithoutEthernet);