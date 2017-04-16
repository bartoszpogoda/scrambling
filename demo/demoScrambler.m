addpath(genpath('model'));

% demo Sygnal
sygnal = Signal(20);             % tworzony sygna³ o d³ugoœci 10 bitów
sygnal.setBit(2);                % ustawiony 2-gi bit (wagi 2^1)
sygnal.setBit(7);                % ustawiony 7-dmy bit (wagi 2^6)  
sygnal.setBit(10);               % ustawiony 10-ty bit (wagi 2^9)  
sygnal.setBit(15);
sygnal.setBit(16);
sygnal.setBit(17);
sygnal.setBit(5);
sygnal.setBit(19);
sygnal.setBit(11);

sygnal2 = sygnal;
% ..0001000010

scrambler = Scrambler();
descrambler = Descrambler();
disp("pocz¹tkowy sygnal"); sygnal.disp();
sygnal2 = scrambler.scramble(sygnal2);
disp("po scramblerze"); sygnal2.disp();
%disp(descrambler.LFSR);
sygnal2 = descrambler.descramble(sygnal2);
disp("po descramblerze"); sygnal2.disp();