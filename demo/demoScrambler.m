addpath(genpath('model'));

% demo Sygnal
sygnal = Sygnal(10);             % tworzony sygna³ o d³ugoœci 10 bitów
sygnal.setBit(2);                % ustawiony 2-gi bit (wagi 2^1)
sygnal.setBit(7);                % ustawiony 7-dmy bit (wagi 2^6)  
sygnal.setBit(10);               % ustawiony 10-ty bit (wagi 2^9)  
sygnal.clearBit(10);             % wyzerowany 10-ty bit (wagi 2^9) 
sygnal.setBitV(4,1);             % ustawiony 4-ty bit (wagi 2^3) 

sygnal2 = sygnal;
sygnal.disp();
sygnal2.disp();
% ..0001000010
%disp("sygnal");
%sygnal.disp();

scrambler = Scrambler();
LFSRs = scrambler.LFSR;
sygnal = scrambler.scramble(sygnal);

disp("scrambler");
sygnal.disp();

descrambler = Scrambler();
LFSRd = descrambler.LFSR;
if(LFSRs == LFSRd)
    disp("Takie same");
end
sygnal2 = descrambler.scramble(sygnal2);

disp("descrambler");
sygnal2.disp();