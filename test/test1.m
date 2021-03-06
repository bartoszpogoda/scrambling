addpath(genpath('view'));
addpath(genpath('model'));
addpath(genpath('helper'));

% COMPONENTS INIT
randomGenerator = RandomGenerator();
encoder = EthernetCoder();
decoder = EthernetDecoder();
scrambler = Scrambler();
descrambler = Descrambler();
channel = CustomChannel();       

% PARAMETERS
testIterations = 1000;                       
randomSignalSize = 640;
randomGenerator.duplProb = 0.60;   
channel.desyncBreakpoint = 12;      
channel.desyncType = 2;             

% TEST LOGIC
summaricBERWithoutEthernet = 0;
summaricBERWithEthernet = 0;
summaricBERWithScrambling = 0;

tic;
for i = 1 : testIterations 
    % GENERATE SIGNAL
    generatedSignal = randomGenerator.generate(randomSignalSize);
    
    % CLEAR TRANSMISSION
    workingSignal = generatedSignal.copy();
    channel.send(workingSignal);
    workingSignal = channel.receive();
    
    summaricBERWithoutEthernet = summaricBERWithoutEthernet + Helper.calculateBER(generatedSignal, workingSignal);
    
    % ETHERNET TRANSMISSION
    workingSignal = generatedSignal.copy();
    workingSignal = encoder.encode(workingSignal);
    channel.send(workingSignal);
    workingSignal = channel.receive();
    workingSignal = decoder.decode(workingSignal);
    
    summaricBERWithEthernet = summaricBERWithEthernet + Helper.calculateBER(generatedSignal, workingSignal);
    
    % SCRAMBLER + ETHERNET TRANSMISSION
    workingSignal = generatedSignal.copy();
    scrambler.resetLFSR();
    descrambler.resetLFSR();
    
    workingSignal = scrambler.scramble(workingSignal);
    workingSignal = encoder.encode(workingSignal);
    channel.send(workingSignal);
    workingSignal = channel.receive();
    workingSignal = decoder.decode(workingSignal);
    descrambled = descrambler.descramble(workingSignal);
    
    summaricBERWithScrambling = summaricBERWithScrambling + Helper.calculateBER(generatedSignal, workingSignal);
end

summaricBERWithEthernet = summaricBERWithEthernet/testIterations;
summaricBERWithoutEthernet = summaricBERWithoutEthernet/testIterations;
summaricBERWithScrambling = summaricBERWithScrambling/testIterations;

% PRINT RESULTS

toc;
disp("PARAMETERS")
disp("Iterations;" + testIterations);
disp("SignalSize;" + randomSignalSize); 
disp("Duplication prob;" + randomGenerator.duplProb);   
disp("Desync breakpoint;" + channel.desyncBreakpoint);
disp("DesyncType;" + channel.desyncType); 
disp("RESULTS");
disp("Nothing;" + summaricBERWithoutEthernet);
disp("Ethernet;" + summaricBERWithEthernet);
disp("ScramblingEthernet;" + summaricBERWithScrambling);