addpath(genpath('model'));

% demo IdealneMedium
idealChannel = IdealChannel;             % tworzone idealne medium

% proba przeslania blednego sygnalu
disp("Error report check:");
idealChannel.send("string");
disp(" ");

% utworzenie poprawnego sygnalu ( 00000010 10000000 00000100 ) = 163 844
% dec
disp("Signal transmission:");
signalSender = Signal(24);             
signalSender.setBit(3);   
signalSender.setBit(16); 
signalSender.setBit(18) 
disp("Value at sender's side: " + signalSender.decValue());    

% przeslanie poprawnego sygnalu po stronie nadawcy
idealChannel.send(signalSender);

% podglad zawartosci medium
idealChannel.disp();

% pobranie przeslanego sygnalu po stronie odbiorcy
signalReceiver = idealChannel.receive();
disp("Value at receiver's side: " + signalReceiver.decValue());
disp(" ");

% zmiana sygna³u po stronie nadawcy nie powinna wywo³aæ zmiany u odbiorcy
disp("After value change at sender's side:");
signalSender.setBit(4);
disp("Value at sender's side: " + signalSender.decValue()); 
disp("Value at receiver's side: " + signalReceiver.decValue()); 
  